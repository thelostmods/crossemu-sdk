#ifndef CROSSEMU_SDK_MATH_VECTOR3_H
#define CROSSEMU_SDK_MATH_VECTOR3_H

    // Byte
    typedef struct { unsigned char  x, y, z; } vector3_b;

    // Shorts
    typedef struct { short          x, y, z; } vector3_hi;
    typedef struct { unsigned short x, y, z; } vector3_hu;

    // Integers
    typedef struct { int            x, y, z; } vector3_i;
    typedef struct { unsigned int   x, y, z; } vector3_u;

    // Longs
    typedef struct { long           x, y, z; } vector3_li;
    typedef struct { unsigned long  x, y, z; } vector3_lu;

    // Decimals
    typedef struct { float          x, y, z; } vector3_f;
    typedef struct { double         x, y, z; } vector3_d;

#endif