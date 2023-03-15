module crossemu.sdk.math.vector2;

export extern(D):

    import std.traits : isNumeric;

    alias Vector2b = Vector2!ubyte;
    alias Vector2s = Vector2!short;
    alias Vector2i = Vector2!int;
    alias Vector2f = Vector2!float;
    alias Vector2l = Vector2!long;
    alias Vector2d = Vector2!double;

    struct Vector2(T) if(isNumeric!T)
    {
        // Byte
             static if (is(T == ubyte))  Vector2_b  self;
        
        // Shorts
        else static if (is(T == short))  Vector2_hi self;
        else static if (is(T == ushort)) Vector2_hu self;
        
        // Integers
        else static if (is(T == int))    Vector2_i  self;
        else static if (is(T == uint))   Vector2_u  self;

        // Longs
        else static if (is(T == long))   Vector2_li self;
        else static if (is(T == ulong))  Vector2_lu self;

        // Decimals
        else static if (is(T == float))  Vector2_f  self;
        else static if (is(T == double)) Vector2_d  self;

        alias self this;
        
        this(N)(N value) if (isNumeric!N)
        {
            x = cast(T) value;
            y = cast(T) value;
        }

        this(N)(N valX, N valY) if (isNumeric!N)
        {
            this.x = cast(T) valX;
            this.y = cast(T) valY;
        }

        this(N)(Vector2!N value)
        {
            x = cast(T) value.x;
            y = cast(T) value.y;
        }
        
        this(ubyte[] buffer)
        {
            auto size = T.sizeof;

            if (buffer.length < (size * 2))
            {
                x = 0;
                y = 0;
            }
            else
            {
                x = *cast(T*) (cast(ubyte*) buffer);
                y = *cast(T*) ((cast(ubyte*) buffer) + size);
            }
        }

        Vector2!T opUnary(string op: "-")() const
        {
            return Vector2!(T)(-x, -y);
        }

        bool opEquals(N)(const N value) const if (isNumeric!N)
        {
            return (
                x == cast(T) value &&
                y == cast(T) value
            );
        }

        bool opEquals(N)(const Vector2!N value)
        {
            return (
                x == cast(T) value.x &&
                y == cast(T) value.y
            );
        }

        Vector2!T opBinary(string op, N)(N value) const if (isNumeric!N)
        {
            return mixin(
                "Vector2!T(" ~
                    "cast(T) (x " ~ op ~ " value)," ~
                    "cast(T) (y " ~ op ~ " value)" ~
                ");"
            );
        }

        Vector2!T opBinary(string op, N)(Vector2!N value) const
        {
            return mixin(
                "Vector2!T(" ~
                    "cast(T) (x " ~ op ~ " value.x)," ~
                    "cast(T) (y " ~ op ~ " value.y)" ~
                ");"
            );
        }

        ref Vector2!T opOpAssign(string op, N)(N value) if (isNumeric!N)
        {
            mixin(
                "x = cast(T) (x " ~ op ~ " value.x);" ~
                "y = cast(T) (y " ~ op ~ " value.y);"
            ); return this;
        }

        ref Vector2!T opOpAssign(string op, N)(Vector2!N value)
        {
            mixin(
                "x = cast(T) (x " ~ op ~ " value.x);" ~
                "y = cast(T) (y " ~ op ~ " value.y);"
            ); return this;
        }

        ref Vector2!T opAssign(N)(N value) if (isNumeric!N)
        {
            x = cast(T) value;
            y = cast(T) value;
            return this;
        }

        ref Vector2!T opAssign(N)(Vector2!N value)
        {
            x = cast(T) value.x;
            y = cast(T) value.y;
            return this;
        }

        void opAssign(ubyte[] buffer)
        {
            auto size = T.sizeof;

            if (buffer.length < (size * 2))
            {
                x = 0;
                y = 0;
            }
            else
            {
                x = *cast(T*) (cast(ubyte*) buffer);
                y = *cast(T*) ((cast(ubyte*) buffer) + size);
            }
        }

        @property ubyte[] toArray()
        {
            size_t size = T.sizeof;
            ubyte[] buffer;
            buffer.length = size * 2;
            
            buffer[0..size] = (cast(ubyte*)&x)[0..size];
            buffer[size..$] = (cast(ubyte*)&y)[0..size];

            return buffer;
        }

        @property string toString() const
        {
            import std.conv : text;
            return text("Vector2(", x, ", ", y, ")");
        }
    }

export extern(C):

    // Byte
    struct Vector2_b  { ubyte  x, y; }

    // Shorts
    struct Vector2_hi { short  x, y; }
    struct Vector2_hu { ushort x, y; }

    // Integers
    struct Vector2_i  { int    x, y; }
    struct Vector2_u  { uint   x, y; }

    // Longs
    struct Vector2_li { long   x, y; }
    struct Vector2_lu { ulong  x, y; }

    // Decimals
    struct Vector2_f  { float  x, y; }
    struct Vector2_d  { double x, y; }
