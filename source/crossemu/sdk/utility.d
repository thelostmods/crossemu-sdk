module crossemu.sdk.utility;

export extern(D):

    string toHex(T)(T input)
    {
        import std.conv : text;
        import std.format : format;
        import std.traits : isArray, isNumeric, isSomeString;
        
        static if(isNumeric!T)
        {
            return format("0x%0" ~ text(2 * T.sizeof) ~ "X", input);
        }
        else static if (isSomeString!T)
        {
            return format("%s", input);
        }
        else static if (is(T==char*) || is(T==const(char*)))
        {
            return format("%s", text(input));
        }
        else static if(isArray!T && T.sizeof == 1)
        {
            string ret;
            foreach (i; input) ret ~= " " ~ format("%02X", i);
            return "0x" ~ ret;
        }
        else assert(0);
    }

export extern(C):

    import std.string : toStringz;

    void  crossemu_sdk_throw_error(const char* error)
    {
        import core.stdc.stdio : printf;
        printf("%s\n", error);

        assert(0);
    }

    char* crossemu_sdk_to_hex_i08(void* input) { return cast(char*) (*cast(ubyte*)  input).toHex().toStringz(); }
    char* crossemu_sdk_to_hex_i16(void* input) { return cast(char*) (*cast(ushort*) input).toHex().toStringz(); }
    char* crossemu_sdk_to_hex_i32(void* input) { return cast(char*) (*cast(uint*)   input).toHex().toStringz(); }
    char* crossemu_sdk_to_hex_i64(void* input) { return cast(char*) (*cast(ulong*)  input).toHex().toStringz(); }
    char* crossemu_sdk_to_hex_f32(void* input) { return cast(char*) (*cast(float*)  input).toHex().toStringz(); }
    char* crossemu_sdk_to_hex_f64(void* input) { return cast(char*) (*cast(double*) input).toHex().toStringz(); }
    char* crossemu_sdk_to_hex_str(void* input, size_t size) { return cast(char*) (cast(char*)  input).toHex().toStringz(); }
    char* crossemu_sdk_to_hex_arr(void* input, size_t size) { return cast(char*) (cast(ubyte*) input)[0..size].toHex().toStringz(); }