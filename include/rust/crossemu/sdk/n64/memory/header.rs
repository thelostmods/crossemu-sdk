extern "C" {
    #[repr(C)]
    struct N64RomHeader {
        pi_bsb_dom1_lat_reg -> u8,         // 0x00
        pi_bsd_dom1_pgs_reg -> u8,         // 0x01
        pi_bsd_dom1_pwd_reg -> u8,         // 0x02
        pi_bsb_dom1_pgs_reg -> u8,         // 0x03
        clock_rate          -> u32,        // 0x04
        program_counter     -> u32,        // 0x08
        release_ptr         -> u32,        // 0x0C
        crc1                -> u32,        // 0x10
        crc2                -> u32,        // 0x14
        unk1                -> [u32; 2],   // 0x18
        name                -> [char; 20], // 0x20
        unk2                -> u32,        // 0x34
        media_format        -> u32,        // 0x38
        game_id             -> u16,        // 0x3C
        country_code        -> char,       // 0x3E
        revision            -> u8          // 0x3F
    }
    
    // global variables
    pub static unsafe g_n64_rom_header: *mut N64RomHeader;
    
    // non-native accessors
    pub static unsafe crossemu_sdk_n64_header_get_ptr() -> *mut N64RomHeader;
    pub static unsafe crossemu_sdk_n64_header_set_ptr(address: *mut N64RomHeader);
    
    /***********************************
    * Returns the cpu clock rate override (Value of 0 uses default)
    */ pub unsafe fn crossemu_sdk_n64_header_clock_rate() -> u32;

    /***********************************
    * Returns the program counter
    */ pub unsafe fn crossemu_sdk_n64_header_program_counter() -> u32;

    /***********************************
    * Returns the first checksum value
    */ pub unsafe fn crossemu_sdk_n64_header_checksum1() -> u32;

    /***********************************
    * Returns the second checksum value
    */ pub unsafe fn crossemu_sdk_n64_header_checksum2() -> 32;

    /***********************************
    * Returns the games 'good-name'.
    */ pub unsafe fn  crossemu_sdk_n64_header_name() -> *const libc::c_char;

    /***********************************
    * Returns the serial-number or game-id
    */ pub unsafe fn crossemu_sdk_n64_header_game_id() -> u16;

    /***********************************
    * Returns the country/region code
    */ pub unsafe fn crossemu_sdk_n64_header_country() -> char;

    /***********************************
    * Returns the revision number
    */ pub unsafe fn crossemu_sdk_n64_header_revision() -> u8;

    /***********************************
    * Returns the revision number
    */ pub unsafe fn  crossemu_sdk_n64_header_release() -> *const libc::c_char;
}