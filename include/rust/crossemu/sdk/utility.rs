extern "C" {
    pub unsafe fn crossemu_sdk_throw(error: *mut libc::c_char);
    pub unsafe fn crossemu_sdk_to_hex_i08(input: *mut libc::c_void) -> *mut libc::c_char;
    pub unsafe fn crossemu_sdk_to_hex_i16(input: *mut libc::c_void) -> *mut libc::c_char;
    pub unsafe fn crossemu_sdk_to_hex_i32(input: *mut libc::c_void) -> *mut libc::c_char;
    pub unsafe fn crossemu_sdk_to_hex_i64(input: *mut libc::c_void) -> *mut libc::c_char;
    pub unsafe fn crossemu_sdk_to_hex_f32(input: *mut libc::c_void) -> *mut libc::c_char;
    pub unsafe fn crossemu_sdk_to_hex_f64(input: *mut libc::c_void) -> *mut libc::c_char;
    pub unsafe fn crossemu_sdk_to_hex_str(input: *mut libc::c_void, size: usize) -> *mut libc::c_char;
    pub unsafe fn crossemu_sdk_to_hex_arr(input: *mut libc::c_void, size: usize) -> *mut libc::c_char;
}