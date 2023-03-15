#ifndef CROSSEMU_SDK_N64_MEMORY_HEADER_H
#define CROSSEMU_SDK_N64_MEMORY_HEADER_H

    #include "../../../import.h"

    typedef struct {
        unsigned char   pi_bsb_dom1_lat_reg; // 0x00
        unsigned char   pi_bsd_dom1_pgs_reg; // 0x01
        unsigned char   pi_bsd_dom1_pwd_reg; // 0x02
        unsigned char   pi_bsb_dom1_pgs_reg; // 0x03
        unsigned int    clock_rate;          // 0x04
        unsigned int    program_counter;     // 0x08
        unsigned int    release_ptr;         // 0x0C
        unsigned int    crc1;                // 0x10
        unsigned int    crc2;                // 0x14
        unsigned int    unk1[2];             // 0x18
        char            name[20];            // 0x20
        unsigned int    unk2;                // 0x34
        unsigned int    media_format;        // 0x38
        unsigned short  game_id;             // 0x3C
        char            country_code;        // 0x3E
        unsigned char   revision;            // 0x3F
    } n64_rom_header;
    
    // global variables
    CROSSEMU_SDK n64_rom_header *g_n64_rom_header;
    
    // non-native accessors
    CROSSEMU_SDK n64_rom_header*  crossemu_sdk_n64_header_get_ptr();
    CROSSEMU_SDK void             crossemu_sdk_n64_header_set_ptr(n64_rom_header* address);

    /***********************************
    * Returns the cpu clock rate override (Value of 0 uses default)
    */ CROSSEMU_SDK unsigned int crossemu_sdk_n64_header_clock_rate();

    /***********************************
    * Returns the program counter
    */ CROSSEMU_SDK unsigned int crossemu_sdk_n64_header_program_counter();

    /***********************************
    * Returns the first checksum value
    */ CROSSEMU_SDK unsigned int crossemu_sdk_n64_header_checksum1();

    /***********************************
    * Returns the second checksum value
    */ CROSSEMU_SDK unsigned int crossemu_sdk_n64_header_checksum2();

    /***********************************
    * Returns the games 'good-name'.
    */ CROSSEMU_SDK const char* crossemu_sdk_n64_header_name();

    /***********************************
    * Returns the serial-number or game-id
    */ CROSSEMU_SDK unsigned short crossemu_sdk_n64_header_game_id();

    /***********************************
    * Returns the country/region code
    */ CROSSEMU_SDK char crossemu_sdk_n64_header_country();

    /***********************************
    * Returns the revision number
    */ CROSSEMU_SDK unsigned char crossemu_sdk_n64_header_revision();

    /***********************************
    * Returns the revision number
    */ CROSSEMU_SDK const char* crossemu_sdk_n64_header_release();

#endif