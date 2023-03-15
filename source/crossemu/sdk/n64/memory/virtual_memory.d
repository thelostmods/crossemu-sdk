module crossemu.sdk.n64.memory.virtual_memory;

uint addrAlign(uint addr) { return 4 * (addr >> 2); }

export extern(C):

    import core.stdc.stdlib : malloc;
    import core.stdc.string : memcpy;

    /***********************************
    * Reads a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The variable pointer where data is being stored.
    *      size       = The size of the variable being passed.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    */
    bool crossemu_sdk_n64_vmem_read_ptr_val(
        uint addr, uint ptr_offset, void* value, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds
    ){
        uint new_addr;

        // check for the initial address at ptr location
        if (!crossemu_sdk_n64_vmem_read_val(
            addr, &new_addr, 4, vmem_ptr,
            check_bounds
        )) return false;

        // return offset results
        return crossemu_sdk_n64_vmem_read_val(
            new_addr + ptr_offset, value, size, vmem_ptr,
            check_bounds
        );
    }

    /***********************************
    * Reads a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The variable pointer where data is being stored.
    *      size  = The size of the variable being passed.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    */
    bool crossemu_sdk_n64_vmem_read_val(
        uint addr, void* value, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds
    ){
        switch (size)
        {
            case 1: // align for int8
                addr = addrAlign(addr) + 3 - (addr & 3);
                break;

            case 2: // align for int16
                addr = addrAlign(addr) + 2 - (addr & 2);
                break;
            
            case 4: case 8: // align for int32/64
                addr = addrAlign(addr);
                break;
            
            default: return false; // not a default value
        }

        if (!check_bounds(addr, size)) return false;

        if (size != 8)
            memcpy(value, vmem_ptr + addr, size);
        else
        {
            memcpy(value + 4, vmem_ptr + addr, 4);
            memcpy(value, vmem_ptr + addr + 4, 4);
        }

        return true;
    }

    /***********************************
    * Reads a string at specified address.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    */
    char* crossemu_sdk_n64_vmem_read_ptr_str(
        uint addr, uint ptr_offset, void* vmem_ptr,
        bool function(uint, size_t) check_bounds
    ){
        uint new_addr;
        
        // check for the initial address at ptr location
        if (!crossemu_sdk_n64_vmem_read_val(
            addr, &new_addr, 4, vmem_ptr,
            check_bounds
        )) { const(char*) ret = "\0"; return cast(char*) ret;}
        
        // return offset results
        return crossemu_sdk_n64_vmem_read_str(
            new_addr + ptr_offset, vmem_ptr,
            check_bounds
        );
    }

    /***********************************
    * Reads a string at specified address.
    *
    * Params:
    *      addr = The location where memory starts.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    */
    char* crossemu_sdk_n64_vmem_read_str(
        uint addr, void* vmem_ptr,
        bool function(uint, size_t) check_bounds
    ){
        if (!check_bounds(addr, 1))
            { const(char*) ret = "\0"; return cast(char*) ret; }
        return cast(char*) (vmem_ptr + addr);
    }

    /***********************************
    * Reads an int8 sized array.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      size       = The length of data to return.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    */
    void* crossemu_sdk_n64_vmem_read_ptr_arr(
        uint addr, uint ptr_offset, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds
    ){
        uint new_addr;

        // check for the initial address at ptr location
        if (!crossemu_sdk_n64_vmem_read_val(
            addr, &new_addr, 4, vmem_ptr,
            check_bounds
        )) return null;
        
        // return offset results
        return crossemu_sdk_n64_vmem_read_arr(
            new_addr + ptr_offset, size, vmem_ptr,
            check_bounds
        );
    }

    /***********************************
    * Reads an int8 sized array.
    *
    * Params:
    *      addr = The location where memory starts.
    *      size = The length of data to return.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    */
    void* crossemu_sdk_n64_vmem_read_arr(
        uint addr, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds
    ){
        if (!check_bounds(addr, size)) return null;

        void* arr = malloc(size);
        if (!arr) return null;

        uint index = addrAlign(addr);
        uint offset = addr & 3;

        for (size_t i = 0;;)
        {
            do
            {
                // extract a u8 from the u32 [vmem]
                memcpy(arr + i, vmem_ptr + index + 3 - offset, 1);
                offset = (offset + 1) & 3;

                // we increment [i] inside the sub loop to short circuit properly
                if (++i == size) return arr;
            } while (offset != 0);

            index += 4;
        }
    }

    /***********************************
    * Reads an int8 sized array.
    * This version does not re-order the mangled byte data from the emulator.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      size       = The length of data to return.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    */
    void* crossemu_sdk_n64_vmem_read_ptr_raw(
        uint addr, uint ptr_offset, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds
    ){
        uint new_addr;

        // check for the initial address at ptr location
        if (!crossemu_sdk_n64_vmem_read_val(
            addr, &new_addr, 4, vmem_ptr,
            check_bounds
        )) return null;

        // return offset results
        return crossemu_sdk_n64_vmem_read_raw(
            new_addr + ptr_offset, size, vmem_ptr,
            check_bounds
        );
    }

    /***********************************
    * Reads an int8 sized array.
    * This version does not re-order the mangled byte data from the emulator.
    *
    * Params:
    *      addr = The location where memory starts.
    *      size = The length of data to return.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    */
    void* crossemu_sdk_n64_vmem_read_raw(
        uint addr, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds
    ){
        if (!check_bounds(addr, size)) return null;

        void* arr = malloc(size);
        if (!arr) return null;

        memcpy(arr, vmem_ptr + addr, size);
        return arr;
    }

    /***********************************
    * Writes a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The variable pointer where data is being pulled.
    *      size       = The size of the variable being passed.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    *      memlog       = A function to print the write request for logging.
    */
    bool crossemu_sdk_n64_vmem_write_ptr_val(
        uint addr, uint ptr_offset, void* value, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    ){
        uint new_addr;

        // check for the initial address at ptr location
        if (!crossemu_sdk_n64_vmem_read_val(
            addr, &new_addr, 4, vmem_ptr,
            check_bounds
        )) return false;

        // return write offset results
        return crossemu_sdk_n64_vmem_write_val(
            new_addr + ptr_offset, value, size, vmem_ptr,
            check_bounds, memlog
        );
    }

    /***********************************
    * Writes a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The variable pointer where data is being pulled.
    *      size  = The size of the variable being passed.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    *      memlog       = A function to print the write request for logging.
    */
    bool crossemu_sdk_n64_vmem_write_val(
        uint addr, void* value, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    ){
        switch (size)
        {
            case 1: // align for int8
                addr = addrAlign(addr) + 3 - (addr & 3);
                break;

            case 2: // align for int16
                addr = addrAlign(addr) + 2 - (addr & 2);
                break;
            
            case 4: case 8: // align for int32/64
                addr = addrAlign(addr);
                break;
            
            default: return false; // not a default value
        }

        if (!check_bounds(addr, size)) return false;

        if (memlog)
            switch (size)
            {
                case 1: memlog(addr, &value, "i08"); break;
                case 2: memlog(addr, &value, "i16"); break;
                case 4: memlog(addr, &value, "i32"); break;
                case 8: memlog(addr, &value, "i64"); break;
                default: return false; // not a default value
            }
        
        if (size != 8)
            memcpy(vmem_ptr + addr, value, size);
        else
        {
            memcpy(vmem_ptr + addr, value + 4, 4);
            memcpy(vmem_ptr + addr + 4, value, 4);
        }

        return true;
    }

    /***********************************
    * Writes a string at specified address.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The string data being passed.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    *      memlog       = A function to print the write request for logging.
    */
    bool crossemu_sdk_n64_vmem_write_ptr_str(
        uint addr, uint ptr_offset, const(char*) value, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    ){
        uint new_addr;

        // check for the initial address at ptr location
        if (!crossemu_sdk_n64_vmem_read_val(
            addr, &new_addr, 4, vmem_ptr,
            check_bounds
        )) return false;

        // return write offset results
        return crossemu_sdk_n64_vmem_write_str(
            new_addr + ptr_offset, value, vmem_ptr,
            check_bounds, memlog
        );
    }

    /***********************************
    * Writes a string at specified address.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The string data being passed.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    *      memlog       = A function to print the write request for logging.
    */
    bool crossemu_sdk_n64_vmem_write_str(
        uint addr, const(char*) value, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    ){
        import core.stdc.string : strlen;
        size_t size = strlen(value);

        if (!check_bounds(addr, size)) return false;

        if (memlog) memlog(addr, cast(void*) value, "str");

        memcpy(vmem_ptr + addr, value, size + 1);
        return true;
    }

    /***********************************
    * Writes an int8 sized array.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The variable pointer where data is being pulled.
    *      size       = The size of the data being passed.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    *      memlog       = A function to print the write request for logging.
    */
    bool crossemu_sdk_n64_vmem_write_ptr_arr(
        uint addr, uint ptr_offset, void* value, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    ){
        uint new_addr;

        // check for the initial address at ptr location
        if (!crossemu_sdk_n64_vmem_read_val(
            addr, &new_addr, 4, vmem_ptr,
            check_bounds
        )) return false;

        // return write offset results
        return crossemu_sdk_n64_vmem_write_arr(
            new_addr + ptr_offset, value, size, vmem_ptr,
            check_bounds, memlog
        );
    }
    
    /***********************************
    * Writes an int8 sized array.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The variable pointer where data is being pulled.
    *      size  = The size of the data being passed.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    *      memlog       = A function to print the write request for logging.
    */
    bool crossemu_sdk_n64_vmem_write_arr(
        uint addr, void* value, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    ){
        if (!check_bounds(addr, size)) return false;

        if (memlog) memlog(addr, value, "arr");

        uint index = addrAlign(addr);
        uint offset = addr & 3;

        for (size_t i = 0;;)
        {
            do
            {
                // inject a u8 into the u32 [vmem]
                memcpy(vmem_ptr + index + 3 - offset, value + i, 1);
                offset = (offset + 1) & 3;

                // we increment [i] inside the sub loop to short circuit properly
                if (++i == size) return true;
            } while (offset != 0);

            index += 4;
        }
    }
    
    /***********************************
    * Writes an int8 sized array.
    * This version does not re-order the mangled byte data for the emulator.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The variable pointer where data is being pulled.
    *      size       = The size of the data being passed.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    *      memlog       = A function to print the write request for logging.
    */
    bool crossemu_sdk_n64_vmem_write_ptr_raw(
        uint addr, uint ptr_offset, void* value, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    ){
        uint new_addr;

        // check for the initial address at ptr location
        if (!crossemu_sdk_n64_vmem_read_val(
            addr, &new_addr, 4, vmem_ptr,
            check_bounds
        )) return false;

        // return write offset results
        return crossemu_sdk_n64_vmem_write_raw(
            new_addr + ptr_offset, value, size, vmem_ptr,
            check_bounds, memlog
        );
    }

    /***********************************
    * Writes an int8 sized array.
    * This version does not re-order the mangled byte data for the emulator.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The variable pointer where data is being pulled.
    *      size  = The size of the data being passed.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    *      memlog       = A function to print the write request for logging.
    */
    bool crossemu_sdk_n64_vmem_write_raw(
        uint addr, void* value, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    ){
        if (!check_bounds(addr, size)) return false;

        if (memlog) memlog(addr, value, "raw");

        memcpy(value, vmem_ptr + addr, size);
        return true;
    }