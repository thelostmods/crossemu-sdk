#ifndef CROSSEMU_SDK_UTILITY_H
#define CROSSEMU_SDK_UTILITY_H

    #include "../import.h"

    CROSSEMU_SDK void  crossemu_sdk_throw(const char* error);
    CROSSEMU_SDK char* crossemu_sdk_to_hex_i08(void* input);
    CROSSEMU_SDK char* crossemu_sdk_to_hex_i16(void* input);
    CROSSEMU_SDK char* crossemu_sdk_to_hex_i32(void* input);
    CROSSEMU_SDK char* crossemu_sdk_to_hex_i64(void* input);
    CROSSEMU_SDK char* crossemu_sdk_to_hex_f32(void* input);
    CROSSEMU_SDK char* crossemu_sdk_to_hex_f64(void* input);
    CROSSEMU_SDK char* crossemu_sdk_to_hex_str(void* input, size_t size);
    CROSSEMU_SDK char* crossemu_sdk_to_hex_arr(void* input, size_t size);

#endif