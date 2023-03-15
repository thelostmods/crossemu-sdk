module crossemu.sdk.n64.memory.rom;

import crossemu.sdk.utility : toHex;

import crossemu.sdk.n64.memory.virtual_memory;

export extern(D):

    /***********************************
    * Utility system containing rom read/write functions
    * Instanced: A uint that stays references rom space
    */
    struct N64Rom
    {
        uint address;
        alias address this;

        /***********************************
        * Overload of operator >> to read data from the address
        */
        void opBinary(string op: ">>", T)(ref T rhs) { rhs = read!T(address); }

        /***********************************
        * Overload of operator << to write data into the address
        */
        void opBinary(string op: "<<", T)(T rhs) { write!T(address, rhs); }

        string toString() { return toHex(address); }

        ref N64Rom opAssign(uint addr) return {
            this.address = addr;
            return this;
        }

        import std.format : format;
        import std.traits : isArray,
                            isNumeric,
                            isSomeString;

        static:
            alias ptr     = g_n64_rom_ptr;
            alias length  = g_n64_rom_len;
            alias logging = g_n64_rom_logging;

        public:
            /***********************************
            * Reads a variable of the specified type.
            *
            * Params:
            *      addr      = The location where memory starts.
            *      ptrOffset = The offset inside the (assumed) struct that addr points to.
            */
            T readPtr(T)(uint addr, uint ptrOffset)
            {
                return read!T(read!uint(addr) + ptrOffset);
            }
            
            /***********************************
            * Reads a variable of the specified type.
            *
            * Params:
            *      addr = The location where memory starts.
            */
            T read(T)(uint addr)
            {
                static if (isSomeString!T)
                {
                    import std.conv : text;
                    return cast(T) text(cast(const char*)
                        crossemu_sdk_n64_rom_read_str(addr));
                }
                else static if (isNumeric!T)
                {
                    T value; 
                    if (!crossemu_sdk_n64_rom_read_val(addr, &value, T.sizeof))
                        return cast(T) 0;
                    return value;
                }
            }
            
            /***********************************
            * Reads an int8 sized array.
            *
            * Params:
            *      addr      = The location where memory starts.
            *      ptrOffset = The offset inside the (assumed) struct that addr points to.
            *      size      = The amount of data (array.length) to return.
            */
            T[] readPtr(T)(uint addr, uint ptrOffset, size_t size) if (T.sizeof == 1)
            {
                return read!T(read!uint(addr) + ptrOffset, size);
            }

            /***********************************
            * Reads an int8 sized array.
            *
            * Params:
            *      addr = The location where memory starts.
            *      size = The amount of data (array.length) to return.
            */
            T[] read(T)(uint addr, size_t size) if (T.sizeof == 1)
            {
                void* value;
                value = crossemu_sdk_n64_rom_read_arr(addr, size);

                if (!value) return new T[0];
                return cast(T) (cast(ubyte*) value)[0..size];
            }

            /***********************************
            * Reads an int8 sized array.
            * This version does not re-order the mangled byte data from the emulator.
            *
            * Params:
            *      addr      = The location where memory starts.
            *      ptrOffset = The offset inside the (assumed) struct that addr points to.
            *      size      = The amount of data (array.length) to return.
            */
            T[] readRawPtr(T)(uint addr, uint ptrOffset, size_t size) if (T.sizeof == 1)
            {
                return readRaw(read!uint(addr) + ptrOffset, size);
            }

            /***********************************
            * Reads an int8 sized array.
            * This version does not re-order the mangled byte data from the emulator.
            *
            * Params:
            *      addr = The location where memory starts.
            *      size = The amount of data (array.length) to return.
            */
            T[] readRaw(T)(uint addr, size_t size) if (T.sizeof == 1)
            {
                void* value;
                value = crossemu_sdk_n64_rom_read_ptr_raw(addr, size);

                if (!value) return new T[0];
                return cast(T) (cast(ubyte*) value)[0..size];
            }

            /***********************************
            * Writes a variable of the specified type.
            *
            * Params:
            *      addr      = The location where a pointer to your data starts.
            *      ptrOffset = The offset inside the (assumed) struct that addr points to.
            *      value     = The data being written in.
            */
            bool writePtr(T)(uint addr, uint ptrOffset, T value)
            {
                return write!T(read!uint(addr) + ptrOffset, value);
            }

            /***********************************
            * Writes a variable of the specified type.
            *
            * Params:
            *      addr  = The location where memory starts.
            *      value = The data being written in.
            */
            bool write(T)(uint addr, T value)
            {
                static if (isSomeString!T)
                {
                    import std.string : toStringz;
                    return crossemu_sdk_n64_rom_write_str(
                        addr, toStringz(cast(string) value));
                }
                else static if (isNumeric!T)
                {
                    return crossemu_sdk_n64_rom_write_val(
                        addr, &value, T.sizeof);
                }
            }
            
            /***********************************
            * Writes an int8 sized array.
            *
            * Params:
            *      addr      = The location where a pointer to your data starts.
            *      ptrOffset = The offset inside the (assumed) struct that addr points to.
            *      value     = The data being written in.
            */
            bool writePtr(T)(uint addr, uint ptrOffset, T[] value) if (T.sizeof == 1)
            {
                return write!T(read!uint(addr) + ptrOffset, value);
            }

            /***********************************
            * Writes an int8 sized array.
            *
            * Params:
            *      addr  = The location where memory starts.
            *      value = The data being written in.
            */
            bool write(T)(uint addr, T[] value) if (T.sizeof == 1)
            {
                return crossemu_sdk_n64_rom_write_arr(
                    addr, cast(void*) value.ptr(), value.length);
            }

            /***********************************
            * Writes an int8 sized array.
            * This version does not re-order the mangled byte data for the emulator.
            *
            * Params:
            *      addr      = The location where a pointer to your data starts.
            *      ptrOffset = The offset inside the (assumed) struct that addr points to.
            *      value     = The data being written in.
            */
            bool writeRawPtr(T)(uint addr, uint ptrOffset, T[] value) if (T.sizeof == 1)
            {
                return writeRaw(read!uint(addr) + ptrOffset, value);
            }

            /***********************************
            * Writes an int8 sized array.
            * This version does not re-order the mangled byte data for the emulator.
            *
            * Params:
            *      addr  = The location where memory starts.
            *      value = The data being written in.
            */
            bool writeRaw(T)(uint addr, T[] value) if (T.sizeof == 1)
            {
                return crossemu_sdk_n64_rom_write_raw(
                    addr, cast(void*) value.ptr(), value.length);
            }
    }

export extern(C):

    // global variables
    static void*   g_n64_rom_ptr;
    static size_t  g_n64_rom_len;
    static bool    g_n64_rom_logging;

    // non-native accessors
    void*  crossemu_sdk_n64_rom_get_ptr() { return g_n64_rom_ptr; }
    void   crossemu_sdk_n64_rom_set_ptr(void* address) { g_n64_rom_ptr = address; }
    
    size_t crossemu_sdk_n64_rom_get_len() { return g_n64_rom_len; }
    void   crossemu_sdk_n64_rom_set_len(size_t size) { g_n64_rom_len = size; }
    
    bool   crossemu_sdk_n64_rom_get_logging() { return g_n64_rom_logging; }
    void   crossemu_sdk_n64_rom_set_logging(bool enabled) { g_n64_rom_logging = enabled; }

    // vmem callbacks
    bool crossemu_sdk_n64_rom_check_bounds(uint addr, size_t size)
    {
        if (addr + size <= g_n64_rom_len) return true;

        /*
        memory_logger(format(
            "Address[%s] or desired read/write Size[%d] is out of bounds!",
            toHex(addr), cast(uint) size
        ));
        */

        return false;
    }

    void crossemu_sdk_n64_rom_memlog(uint addr, void* value, const(char*) type)
    {
        // import std.conv : text;

        // auto msg = "N64Rom.write!%s(%s, %s)";

        // static if (isSomeString!T) 
        //     format(msg, "str", toHex(addr), text(value));
        // else static if (isArray!T) 
        //     format(msg, "arr", toHex(addr), text(value.sizeof));
        // else static if (isNumeric!T)
        //     format(msg, text(T.sizeof * 8), toHex(addr), text(value) ~ ", " ~ toHex(value));
        // else
        //     format(msg, "obj", toHex(addr), text(T.sizeof));

        // memory_logger(msg);
    }

    /***********************************
    * Reads a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The variable pointer where data is being stored.
    *      size       = The size of the variable being passed.
    */
    bool crossemu_sdk_n64_rom_read_ptr_val(uint addr, uint ptr_offset, void* value, size_t size)
    {
        return crossemu_sdk_n64_vmem_read_ptr_val(
            addr, ptr_offset, value, size, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds
        );
    }

    /***********************************
    * Reads a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The variable pointer where data is being stored.
    *      size  = The size of the variable being passed.
    */
    bool crossemu_sdk_n64_rom_read_val(uint addr, void* value, size_t size)
    {
        return crossemu_sdk_n64_vmem_read_val(
            addr, value, size, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds
        );
    }

    /***********************************
    * Reads a string at specified address.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    */
    char* crossemu_sdk_n64_rom_read_ptr_str(uint addr, uint ptr_offset)
    {
        return crossemu_sdk_n64_vmem_read_ptr_str(
            addr, ptr_offset, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds
        );
    }

    /***********************************
    * Reads a string at specified address.
    *
    * Params:
    *      addr = The location where memory starts.
    */
    char* crossemu_sdk_n64_rom_read_str(uint addr)
    {
        return crossemu_sdk_n64_vmem_read_str(
            addr, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds
        );
    }

    /***********************************
    * Reads an int8 sized array.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      size       = The length of data to return.
    */
    void* crossemu_sdk_n64_rom_read_ptr_arr(uint addr, uint ptr_offset, size_t size)
    {
        return crossemu_sdk_n64_vmem_read_ptr_arr(
            addr, ptr_offset, size, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds
        );
    }

    /***********************************
    * Reads an int8 sized array.
    *
    * Params:
    *      addr = The location where memory starts.
    *      size = The length of data to return.
    */
    void* crossemu_sdk_n64_rom_read_arr(uint addr, size_t size)
    {
        return crossemu_sdk_n64_vmem_read_arr(
            addr, size, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds
        );
    }

    /***********************************
    * Reads an int8 sized array.
    * This version does not re-order the mangled byte data from the emulator.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      size       = The length of data to return.
    */
    void* crossemu_sdk_n64_rom_read_ptr_raw(uint addr, uint ptr_offset, size_t size)
    {
        return crossemu_sdk_n64_vmem_read_ptr_raw(
            addr, ptr_offset, size, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds
        );
    }

    /***********************************
    * Reads an int8 sized array.
    * This version does not re-order the mangled byte data from the emulator.
    *
    * Params:
    *      addr = The location where memory starts.
    *      size = The length of data to return.
    */
    void* crossemu_sdk_n64_rom_read_raw(uint addr, size_t size)
    {
        return crossemu_sdk_n64_vmem_read_raw(
            addr, size, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds
        );
    }

    /***********************************
    * Writes a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The variable pointer where data is being pulled.
    *      size       = The size of the variable being passed.
    */
    bool crossemu_sdk_n64_rom_write_ptr_val(uint addr, uint ptr_offset, void* value, size_t size)
    {
        return crossemu_sdk_n64_vmem_write_ptr_val(
            addr, ptr_offset, value, size, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds,
            (g_n64_rom_logging ? &crossemu_sdk_n64_rom_memlog : null)
        );
    }

    /***********************************
    * Writes a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The variable pointer where data is being pulled.
    *      size  = The size of the variable being passed.
    */
    bool crossemu_sdk_n64_rom_write_val(uint addr, void* value, size_t size)
    {
        return crossemu_sdk_n64_vmem_write_val(
            addr, value, size, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds,
            (g_n64_rom_logging ? &crossemu_sdk_n64_rom_memlog : null)
        );
    }

    /***********************************
    * Writes a string at specified address.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The string data being passed.
    */
    bool crossemu_sdk_n64_rom_write_ptr_str(uint addr, uint ptr_offset, const(char*) value)
    {
        return crossemu_sdk_n64_vmem_write_ptr_str(
            addr, ptr_offset, value, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds,
            (g_n64_rom_logging ? &crossemu_sdk_n64_rom_memlog : null)
        );
    }

    /***********************************
    * Writes a string at specified address.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The string data being passed.
    */
    bool crossemu_sdk_n64_rom_write_str(uint addr, const(char*) value)
    {
        return crossemu_sdk_n64_vmem_write_str(
            addr, value, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds,
            (g_n64_rom_logging ? &crossemu_sdk_n64_rom_memlog : null)
        );
    }

    /***********************************
    * Writes an int8 sized array.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The variable pointer where data is being pulled.
    *      size       = The size of the data being passed.
    */
    bool crossemu_sdk_n64_rom_write_ptr_arr(uint addr, uint ptr_offset, void* value, size_t size)
    {
        return crossemu_sdk_n64_vmem_write_ptr_arr(
            addr, ptr_offset, value, size, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds,
            (g_n64_rom_logging ? &crossemu_sdk_n64_rom_memlog : null)
        );
    }
    
    /***********************************
    * Writes an int8 sized array.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The variable pointer where data is being pulled.
    *      size  = The size of the data being passed.
    */
    bool crossemu_sdk_n64_rom_write_arr(uint addr, void* value, size_t size)
    {
        return crossemu_sdk_n64_vmem_write_arr(
            addr, value, size, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds,
            (g_n64_rom_logging ? &crossemu_sdk_n64_rom_memlog : null)
        );
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
    */
    bool crossemu_sdk_n64_rom_write_ptr_raw(uint addr, uint ptr_offset, void* value, size_t size)
    {
        return crossemu_sdk_n64_vmem_write_ptr_raw(
            addr, ptr_offset, value, size, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds,
            (g_n64_rom_logging ? &crossemu_sdk_n64_rom_memlog : null)
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
    */
    bool crossemu_sdk_n64_rom_write_raw(uint addr, void* value, size_t size)
    {
        return crossemu_sdk_n64_vmem_write_raw(
            addr, value, size, g_n64_rom_ptr,
            &crossemu_sdk_n64_rom_check_bounds,
            (g_n64_rom_logging ? &crossemu_sdk_n64_rom_memlog : null)
        );
    }