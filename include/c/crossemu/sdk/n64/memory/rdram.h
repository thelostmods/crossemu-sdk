#ifndef CROSSEMU_SDK_N64_MEMORY_RDRAM_H
#define CROSSEMU_SDK_N64_MEMORY_RDRAM_H

    #include "../../../import.h"

    #ifndef __cplusplus
        #include <stdbool.h>
        #include "stddef.h"
    #endif

    // global variables
    CROSSEMU_SDK void*   g_n64_rdram_ptr;
    CROSSEMU_SDK size_t  g_n64_rdram_len;
    CROSSEMU_SDK bool    g_n64_rdram_logging;

    // non-native accessors
    CROSSEMU_SDK void*  crossemu_sdk_n64_rdram_get_ptr();
    CROSSEMU_SDK void   crossemu_sdk_n64_rdram_set_ptr(void* address);
    
    CROSSEMU_SDK size_t crossemu_sdk_n64_rdram_get_len();
    CROSSEMU_SDK void   crossemu_sdk_n64_rdram_set_len(size_t size);
    
    CROSSEMU_SDK bool   crossemu_sdk_n64_rdram_get_logging();
    CROSSEMU_SDK void   crossemu_sdk_n64_rdram_set_logging(bool enabled);

    // vmem callbacks
    CROSSEMU_SDK bool crossemu_sdk_n64_rdram_check_bounds(unsigned int addr, size_t size);
    CROSSEMU_SDK void crossemu_sdk_n64_rdram_memlog(unsigned int addr, void* value, const char* type);

    /***********************************
    * Reads a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The variable pointer where data is being stored.
    *      size       = The size of the variable being passed.
    */ CROSSEMU_SDK bool crossemu_sdk_n64_rdram_read_ptr_val(unsigned int addr, unsigned int ptr_offset, void* value, size_t size);

    /***********************************
    * Reads a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The variable pointer where data is being stored.
    *      size  = The size of the variable being passed.
    */ CROSSEMU_SDK bool crossemu_sdk_n64_rdram_read_val(unsigned int addr, void* value, size_t size);

    /***********************************
    * Reads a string at specified address.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    */ CROSSEMU_SDK const char* crossemu_sdk_n64_rdram_read_ptr_str(unsigned int addr, unsigned int ptr_offset);

    /***********************************
    * Reads a string at specified address.
    *
    * Params:
    *      addr = The location where memory starts.
    */ CROSSEMU_SDK const char* crossemu_sdk_n64_rdram_read_str(unsigned int addr);

    /***********************************
    * Reads an int8 sized array.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      size       = The length of data to return.
    */ CROSSEMU_SDK void* crossemu_sdk_n64_rdram_read_ptr_arr(unsigned int addr, unsigned int ptr_offset, size_t size);

    /***********************************
    * Reads an int8 sized array.
    *
    * Params:
    *      addr = The location where memory starts.
    *      size = The length of data to return.
    */ CROSSEMU_SDK void* crossemu_sdk_n64_rdram_read_arr(unsigned int addr, size_t size);

    /***********************************
    * Reads an int8 sized array.
    * This version does not re-order the mangled byte data from the emulator.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      size       = The length of data to return.
    */ CROSSEMU_SDK void* crossemu_sdk_n64_rdram_read_ptr_raw(unsigned int addr, unsigned int ptr_offset, size_t size);

    /***********************************
    * Reads an int8 sized array.
    * This version does not re-order the mangled byte data from the emulator.
    *
    * Params:
    *      addr = The location where memory starts.
    *      size = The length of data to return.
    */ CROSSEMU_SDK void* crossemu_sdk_n64_rdram_read_raw(unsigned int addr, size_t size);

    /***********************************
    * Writes a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The variable pointer where data is being pulled.
    *      size       = The size of the variable being passed.
    */ CROSSEMU_SDK bool crossemu_sdk_n64_rdram_write_ptr_val(unsigned int addr, unsigned int ptr_offset, void* value, size_t size);

    /***********************************
    * Writes a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The variable pointer where data is being pulled.
    *      size  = The size of the variable being passed.
    */ CROSSEMU_SDK bool crossemu_sdk_n64_rdram_write_val(unsigned int addr, void* value, size_t size);

    /***********************************
    * Writes a string at specified address.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The string data being passed.
    */ CROSSEMU_SDK bool crossemu_sdk_n64_rdram_write_ptr_str(unsigned int addr, unsigned int ptr_offset, const char* value);

    /***********************************
    * Writes a string at specified address.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The string data being passed.
    */ CROSSEMU_SDK bool crossemu_sdk_n64_rdram_write_str(unsigned int addr, const char* value);

    /***********************************
    * Writes an int8 sized array.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The variable pointer where data is being pulled.
    *      size       = The size of the data being passed.
    */ CROSSEMU_SDK bool crossemu_sdk_n64_rdram_write_ptr_arr(unsigned int addr, unsigned int ptr_offset, void* value, size_t size);
    
    /***********************************
    * Writes an int8 sized array.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The variable pointer where data is being pulled.
    *      size  = The size of the data being passed.
    */ CROSSEMU_SDK bool crossemu_sdk_n64_rdram_write_arr(unsigned int addr, void* value, size_t size);
    
    /***********************************
    * Writes an int8 sized array.
    * This version does not re-order the mangled byte data for the emulator.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The variable pointer where data is being pulled.
    *      size       = The size of the data being passed.
    */ CROSSEMU_SDK bool crossemu_sdk_n64_rdram_write_ptr_raw(unsigned int addr, unsigned int ptr_offset, void* value, size_t size);

    /***********************************
    * Writes an int8 sized array.
    * This version does not re-order the mangled byte data for the emulator.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The variable pointer where data is being pulled.
    *      size  = The size of the data being passed.
    */ CROSSEMU_SDK bool crossemu_sdk_n64_rdram_write_raw(unsigned int addr, void* value, size_t size);

#endif