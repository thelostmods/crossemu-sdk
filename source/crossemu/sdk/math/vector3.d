module crossemu.sdk.math.vector3;

export extern(D):

    import std.traits : isNumeric;

    alias Vector3b = Vector3!ubyte;
    alias Vector3s = Vector3!short;
    alias Vector3i = Vector3!int;
    alias Vector3f = Vector3!float;
    alias Vector3l = Vector3!long;
    alias Vector3d = Vector3!double;

    struct Vector3(T) if(isNumeric!T)
    {
        // Byte
             static if (is(T == ubyte))  Vector3_b  self;
        
        // Shorts
        else static if (is(T == short))  Vector3_hi self;
        else static if (is(T == ushort)) Vector3_hu self;
        
        // Integers
        else static if (is(T == int))    Vector3_i  self;
        else static if (is(T == uint))   Vector3_u  self;

        // Longs
        else static if (is(T == long))   Vector3_li self;
        else static if (is(T == ulong))  Vector3_lu self;

        // Decimals
        else static if (is(T == float))  Vector3_f  self;
        else static if (is(T == double)) Vector3_d  self;

        alias self this;

        this(N)(N value) if (isNumeric!N)
        {
            x = cast(T) value;
            y = cast(T) value;
            z = cast(T) value;
        }

        this(N)(N valX, N valY, N valZ) if (isNumeric!N)
        {
            this.x = cast(T) valX;
            this.y = cast(T) valY;
            this.z = cast(T) valZ;
        }

        this(N)(Vector3!N value)
        {
            x = cast(T) value.x;
            y = cast(T) value.y;
            z = cast(T) value.z;
        }
        
        this(ubyte[] buffer)
        {
            auto size = T.sizeof;

            if (buffer.length < (size * 3))
            {
                x = 0;
                y = 0;
                z = 0;
            }
            else
            {
                x = *cast(T*) (cast(ubyte*) buffer);
                y = *cast(T*) ((cast(ubyte*) buffer) + size);
                z = *cast(T*) ((cast(ubyte*) buffer) + size * 2);
            }
        }

        Vector3!T opUnary(string op: "-")() const
        {
            return Vector3!(T)(-x, -y, -z);
        }

        bool opEquals(N)(const N value) const if (isNumeric!N)
        {
            return (
                x == cast(T) value &&
                y == cast(T) value &&
                z == cast(T) value
            );
        }

        bool opEquals(N)(const Vector3!N value)
        {
            return (
                x == cast(T) value.x &&
                y == cast(T) value.y &&
                z == cast(T) value.z
            );
        }

        Vector3!T opBinary(string op, N)(N value) const if (isNumeric!N)
        {
            return mixin(
                "Vector3!T(" ~
                    "cast(T) (x " ~ op ~ " value)," ~
                    "cast(T) (y " ~ op ~ " value)," ~
                    "cast(T) (z " ~ op ~ " value)" ~
                ");"
            );
        }

        Vector3!T opBinary(string op, N)(Vector3!N value) const
        {
            return mixin(
                "Vector3!T(" ~
                    "cast(T) (x " ~ op ~ " value.x)," ~
                    "cast(T) (y " ~ op ~ " value.y)," ~
                    "cast(T) (z " ~ op ~ " value.z)" ~
                ");"
            );
        }

        ref Vector3!T opOpAssign(string op, N)(N value) if (isNumeric!N)
        {
            mixin(
                "x = cast(T) (x " ~ op ~ " value.x);" ~
                "y = cast(T) (y " ~ op ~ " value.y);" ~
                "z = cast(T) (z " ~ op ~ " value.z);"
            ); return this;
        }

        ref Vector3!T opOpAssign(string op, N)(Vector3!N value)
        {
            mixin(
                "x = cast(T) (x " ~ op ~ " value.x);" ~
                "y = cast(T) (y " ~ op ~ " value.y);" ~
                "z = cast(T) (z " ~ op ~ " value.z);"
            ); return this;
        }

        ref Vector3!T opAssign(N)(N value) if (isNumeric!N)
        {
            x = cast(T) value;
            y = cast(T) value;
            z = cast(T) value;
            return this;
        }

        ref Vector3!T opAssign(N)(Vector3!N value)
        {
            x = cast(T) value.x;
            y = cast(T) value.y;
            z = cast(T) value.z;
            return this;
        }

        void opAssign(ubyte[] buffer)
        {
            auto size = T.sizeof;

            if (buffer.length < (size * 3))
            {
                x = 0;
                y = 0;
                z = 0;
            }
            else
            {
                x = *cast(T*) (cast(ubyte*) buffer);
                y = *cast(T*) ((cast(ubyte*) buffer) + size);
                z = *cast(T*) ((cast(ubyte*) buffer) + size * 2);
            }
        }

        @property ubyte[] toArray()
        {
            size_t size = T.sizeof;
            ubyte[] buffer;
            buffer.length = size * 3;
            
            buffer[0..size] = (cast(ubyte*)&x)[0..size];
            buffer[size..size * 2] = (cast(ubyte*)&y)[0..size];
            buffer[size * 2..$] = (cast(ubyte*)&z)[0..size];

            return buffer;
        }

        @property string toString() const
        {
            import std.conv : text;
            return text("Vector3(", x, ", ", y, ", ", z, ")");
        }
    }

export extern(C):

    // Byte
    struct Vector3_b  { ubyte  x, y, z; }

    // Shorts
    struct Vector3_hi { short  x, y, z; }
    struct Vector3_hu { ushort x, y, z; }

    // Integers
    struct Vector3_i  { int    x, y, z; }
    struct Vector3_u  { uint   x, y, z; }

    // Longs
    struct Vector3_li { long   x, y, z; }
    struct Vector3_lu { ulong  x, y, z; }

    // Decimals
    struct Vector3_f  { float  x, y, z; }
    struct Vector3_d  { double x, y, z; }
