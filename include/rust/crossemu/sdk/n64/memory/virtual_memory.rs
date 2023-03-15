extern "C" {

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
    */ bool crossemu_sdk_n64_vmem_read_ptr_val(
        uint addr, uint ptr_offset, void* value, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds
    );

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
    );

    /***********************************
    * Reads a string at specified address.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    */ char* crossemu_sdk_n64_vmem_read_ptr_str(
        uint addr, uint ptr_offset, void* vmem_ptr,
        bool function(uint, size_t) check_bounds
    );

    /***********************************
    * Reads a string at specified address.
    *
    * Params:
    *      addr = The location where memory starts.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    */ char* crossemu_sdk_n64_vmem_read_str(
        uint addr, void* vmem_ptr,
        bool function(uint, size_t) check_bounds
    );

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
    );

    /***********************************
    * Reads an int8 sized array.
    *
    * Params:
    *      addr = The location where memory starts.
    *      size = The length of data to return.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    */ void* crossemu_sdk_n64_vmem_read_arr(
        uint addr, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds
    );

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
    */ void* crossemu_sdk_n64_vmem_read_ptr_raw(
        uint addr, uint ptr_offset, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds
    );

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
    */ void* crossemu_sdk_n64_vmem_read_raw(
        uint addr, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds
    );

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
    */ bool crossemu_sdk_n64_vmem_write_ptr_val(
        uint addr, uint ptr_offset, void* value, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    );

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
    */ bool crossemu_sdk_n64_vmem_write_val(
        uint addr, void* value, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    );

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
    */ bool crossemu_sdk_n64_vmem_write_ptr_str(
        uint addr, uint ptr_offset, const(char*) value, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    );

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
    */ bool crossemu_sdk_n64_vmem_write_str(
        uint addr, const(char*) value, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    );

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
    */ bool crossemu_sdk_n64_vmem_write_ptr_arr(
        uint addr, uint ptr_offset, void* value, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    );
    
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
    */ bool crossemu_sdk_n64_vmem_write_arr(
        uint addr, void* value, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    );
    
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
    */ bool crossemu_sdk_n64_vmem_write_ptr_raw(
        uint addr, uint ptr_offset, void* value, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    );

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
    */ bool crossemu_sdk_n64_vmem_write_raw(
        uint addr, void* value, size_t size, void* vmem_ptr,
        bool function(uint, size_t) check_bounds,
        void function(uint, void*, const(char*)) memlog
    );
}