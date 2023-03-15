extern "C" {
    // global variables
    pub static unsafe g_n64_rom_ptr:     *mut libc::c_void;
    pub static unsafe g_n64_rom_len:     usize;
    pub static unsafe g_n64_rom_logging: bool;

    // non-native accessors
    pub unsafe fn crossemu_sdk_n64_rom_get_ptr() -> *mut libc::c_void;
    pub unsafe fn crossemu_sdk_n64_rom_set_ptr(address: *mut libc::c_void);
    
    pub unsafe fn crossemu_sdk_n64_rom_get_len() -> usize;
    pub unsafe fn crossemu_sdk_n64_rom_set_len(usize size);
    
    pub unsafe fn crossemu_sdk_n64_rom_get_logging() -> bool;
    pub unsafe fn crossemu_sdk_n64_rom_set_logging(bool enabled);

    // vmem callbacks
    pub unsafe fn crossemu_sdk_n64_rom_check_bounds(unsigned int addr, size_t size) -> bool;
    pub unsafe fn crossemu_sdk_n64_rom_memlog(unsigned int addr, void* value, const char* type);

    /***********************************
    * Reads a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The variable pointer where data is being stored.
    *      size       = The size of the variable being passed.
    */ pub unsafe fn crossemu_sdk_n64_rom_read_ptr_val(addr: u32, ptr_offset: u32, value: *mut libc::c_void, size: usize) -> bool;

    /***********************************
    * Reads a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The variable pointer where data is being stored.
    *      size  = The size of the variable being passed.
    */ pub unsafe fn crossemu_sdk_n64_rom_read_val(addr: u32, value: *mut libc::c_void, size: usize) -> bool;

    /***********************************
    * Reads a string at specified address.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    */ pub unsafe fn crossemu_sdk_n64_rom_read_ptr_str(addr: u32, ptr_offset: u32) -> *mut libc::c_char;

    /***********************************
    * Reads a string at specified address.
    *
    * Params:
    *      addr = The location where memory starts.
    */ pub unsafe fn crossemu_sdk_n64_rom_read_str(addr: u32) -> *mut libc::c_char;

    /***********************************
    * Reads an int8 sized array.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      size       = The length of data to return.
    */ pub unsafe fn crossemu_sdk_n64_rom_read_ptr_arr(addr: u32, ptr_offset: u32, size: usize) -> *mut libc::c_void;

    /***********************************
    * Reads an int8 sized array.
    *
    * Params:
    *      addr = The location where memory starts.
    *      size = The length of data to return.
    */ pub unsafe fn crossemu_sdk_n64_rom_read_arr(addr: u32, size: usize) -> *mut libc::c_void;

    /***********************************
    * Reads an int8 sized array.
    * This version does not re-order the mangled byte data from the emulator.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      size       = The length of data to return.
    */ pub unsafe fn crossemu_sdk_n64_rom_read_ptr_raw(addr: u32, ptr_offset: u32, size: usize) -> *mut libc::c_void;

    /***********************************
    * Reads an int8 sized array.
    * This version does not re-order the mangled byte data from the emulator.
    *
    * Params:
    *      addr = The location where memory starts.
    *      size = The length of data to return.
    */ pub unsafe fn crossemu_sdk_n64_rom_read_raw(addr: u32, size: usize) -> *mut libc::c_void;

    /***********************************
    * Writes a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The variable pointer where data is being pulled.
    *      size       = The size of the variable being passed.
    */ pub unsafe fn crossemu_sdk_n64_rom_write_ptr_val(addr: u32, ptr_offset: u32, value: *mut libc::c_void, size: usize) -> bool;

    /***********************************
    * Writes a variable of int8, int16, int32, or int64 size.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The variable pointer where data is being pulled.
    *      size  = The size of the variable being passed.
    */ pub unsafe fn crossemu_sdk_n64_rom_write_val(addr: u32, value: *mut libc::c_void, size: usize) -> bool;

    /***********************************
    * Writes a string at specified address.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The string data being passed.
    */ pub unsafe fn crossemu_sdk_n64_rom_write_ptr_str(addr: u32, ptr_offset: u32, const char* value) -> bool;

    /***********************************
    * Writes a string at specified address.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The string data being passed.
    */ pub unsafe fn crossemu_sdk_n64_rom_write_str(addr: u32, const char* value) -> bool;

    /***********************************
    * Writes an int8 sized array.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The variable pointer where data is being pulled.
    *      size       = The size of the data being passed.
    */ pub unsafe fn crossemu_sdk_n64_rom_write_ptr_arr(addr: u32, ptr_offset: u32, value: *mut libc::c_void, size: usize) -> bool;
    
    /***********************************
    * Writes an int8 sized array.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The variable pointer where data is being pulled.
    *      size  = The size of the data being passed.
    */ pub unsafe fn crossemu_sdk_n64_rom_write_arr(addr: u32, value: *mut libc::c_void, size: usize) -> bool;
    
    /***********************************
    * Writes an int8 sized array.
    * This version does not re-order the mangled byte data for the emulator.
    *
    * Params:
    *      addr       = The location where memory starts.
    *      ptr_offset = The offset inside the (assumed) struct that addr points to.
    *      value      = The variable pointer where data is being pulled.
    *      size       = The size of the data being passed.
    */ pub unsafe fn crossemu_sdk_n64_rom_write_ptr_raw(addr: u32, ptr_offset: u32, value: *mut libc::c_void: *mut libc::c_void, size: usize) -> bool;

    /***********************************
    * Writes an int8 sized array.
    * This version does not re-order the mangled byte data for the emulator.
    *
    * Params:
    *      addr  = The location where memory starts.
    *      value = The variable pointer where data is being pulled.
    *      size  = The size of the data being passed.
    */ pub unsafe fn crossemu_sdk_n64_rom_write_raw(addr: u32, value: *mut libc::c_void, size: usize) -> bool;
}