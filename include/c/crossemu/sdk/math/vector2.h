#ifndef CROSSEMU_SDK_MATH_VECTOR2_H
#define CROSSEMU_SDK_MATH_VECTOR2_H

    // Byte
    typedef struct { unsigned char  x, y; } vector2_b;

    // Shorts
    typedef struct { short          x, y; } vector2_hi;
    typedef struct { unsigned short x, y; } vector2_hu;

    // Integers
    typedef struct { int            x, y; } vector2_i;
    typedef struct { unsigned int   x, y; } vector2_u;

    // Longs
    typedef struct { long           x, y; } vector2_li;
    typedef struct { unsigned long  x, y; } vector2_lu;

    // Decimals
    typedef struct { float          x, y; } vector2_f;
    typedef struct { double         x, y; } vector2_d;

#endif