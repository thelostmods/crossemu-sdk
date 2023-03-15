#ifndef CROSSEMU_SDK_N64_TYPES_HARDWARE_H
#define CROSSEMU_SDK_N64_TYPES_HARDWARE_H

    #include "../../../import.h"

    typedef enum {
        N64_BUTTON_CRIGHT = 0x0001,
        N64_BUTTON_CLEFT  = 0x0002,
        N64_BUTTON_CDOWN  = 0x0004,
        N64_BUTTON_CUP    = 0x0008,
        N64_BUTTON_R      = 0x0010,
        N64_BUTTON_L      = 0x0020,
        N64_BUTTON_DRIGHT = 0x0100,
        N64_BUTTON_DLEFT  = 0x0200,
        N64_BUTTON_DDOWN  = 0x0400,
        N64_BUTTON_DUP    = 0x0800,
        N64_BUTTON_START  = 0x1000,
        N64_BUTTON_Z      = 0x2000,
        N64_BUTTON_B      = 0x4000,
        N64_BUTTON_A      = 0x8000
    } n64_button;

#endif