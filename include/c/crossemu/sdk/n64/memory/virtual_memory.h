#ifndef CROSSEMU_SDK_N64_MEMORY_VMEM_H
#define CROSSEMU_SDK_N64_MEMORY_VMEM_H

    #include "../../../import.h"

    #ifndef __cplusplus
        #include <stdbool.h>
        #include "stddef.h"
    #endif

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
    *      check_bounds = A function to check memory bounds with address request
    */ CROSSEMU_SDK bool crossemu_sdk_n64_vmem_read_ptr_val(
        unsigned int addr, unsigned int ptr_offset, void* value, size_t size, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds
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
    */ CROSSEMU_SDK bool crossemu_sdk_n64_vmem_read_val(
        unsigned int addr, void* value, size_t size, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds
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
    */ CROSSEMU_SDK char* crossemu_sdk_n64_vmem_read_ptr_str(
        unsigned int addr, unsigned int ptr_offset, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds
    );

    /***********************************
    * Reads a string at specified address.
    *
    * Params:
    *      addr = The location where memory starts.
    *
    *      vmem_ptr     = A pointer to the virtual memory type.
    *      check_bounds = A function to check memory bounds with address request.
    */ CROSSEMU_SDK char* crossemu_sdk_n64_vmem_read_str(
        unsigned int addr, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds
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
    */ CROSSEMU_SDK void* crossemu_sdk_n64_vmem_read_ptr_arr(
        unsigned int addr, unsigned int ptr_offset, size_t size, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds
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
    */ CROSSEMU_SDK void* crossemu_sdk_n64_vmem_read_arr(
        unsigned int addr, size_t size, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds
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
    */ CROSSEMU_SDK void* crossemu_sdk_n64_vmem_read_ptr_raw(
        unsigned int addr, unsigned int ptr_offset, size_t size, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds
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
    */ CROSSEMU_SDK void* crossemu_sdk_n64_vmem_read_raw(
        unsigned int addr, size_t size, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds
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
    */ CROSSEMU_SDK bool crossemu_sdk_n64_vmem_write_ptr_val(
        unsigned int addr, unsigned int ptr_offset, void* value, size_t size, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds,
        void (*)(unsigned int, void*, const(char*)) memlog
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
    */ CROSSEMU_SDK bool crossemu_sdk_n64_vmem_write_val(
        unsigned int addr, void* value, size_t size, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds,
        void (*)(unsigned int, void*, const(char*)) memlog
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
    */ CROSSEMU_SDK bool crossemu_sdk_n64_vmem_write_ptr_str(
        unsigned int addr, unsigned int ptr_offset, const(char*) value, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds,
        void (*)(unsigned int, void*, const(char*)) memlog
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
    */ CROSSEMU_SDK bool crossemu_sdk_n64_vmem_write_str(
        unsigned int addr, const(char*) value, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds,
        void (*)(unsigned int, void*, const(char*)) memlog
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
    */ CROSSEMU_SDK bool crossemu_sdk_n64_vmem_write_ptr_arr(
        unsigned int addr, unsigned int ptr_offset, void* value, size_t size, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds,
        void (*)(unsigned int, void*, const(char*)) memlog
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
    */ CROSSEMU_SDK bool crossemu_sdk_n64_vmem_write_arr(
        unsigned int addr, void* value, size_t size, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds,
        void (*)(unsigned int, void*, const(char*)) memlog
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
    */ CROSSEMU_SDK bool crossemu_sdk_n64_vmem_write_ptr_raw(
        unsigned int addr, unsigned int ptr_offset, void* value, size_t size, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds,
        void (*)(unsigned int, void*, const(char*)) memlog
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
    */ CROSSEMU_SDK bool crossemu_sdk_n64_vmem_write_raw(
        unsigned int addr, void* value, size_t size, void* vmem_ptr,
        bool (*)(unsigned int, size_t) check_bounds,
        void (*)(unsigned int, void*, const(char*)) memlog
    );