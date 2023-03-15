module crossemu.sdk.n64.memory.header;

export extern(D):

    /***********************************
    * Utility system for reading the components in the rom header
    */
    struct N64RomHeader
    {
        ubyte    pi_bsb_dom1_lat_reg; // 0x00
        ubyte    pi_bsd_dom1_pgs_reg; // 0x01
        ubyte    pi_bsd_dom1_pwd_reg; // 0x02
        ubyte    pi_bsb_dom1_pgs_reg; // 0x03
        uint     clockRate;           // 0x04
        uint     programCounter;      // 0x08
        uint     releasePtr;          // 0x0C
        uint     crc1;                // 0x10
        uint     crc2;                // 0x14
        uint[2]  unk1;                // 0x18
        char[20] name;                // 0x20
        uint     unk2;                // 0x34
        uint     mediaFormat;         // 0x38
        ushort   gameID;              // 0x3C
        char     countryCode;         // 0x3E
        ubyte    revision;            // 0x3F
        
        static:
            import std.conv : text;

            alias ptr = g_n64_rom_header;
        
            /***********************************
            * Returns the cpu clock rate override (Value of 0 uses default)
            */
            @property static uint getClockRate()
            {
                return ptr.clockRate;
            }

            /***********************************
            * Returns the program counter
            */
            @property static uint getProgramCounter()
            {
                return ptr.programCounter;
            }

            /***********************************
            * Returns the first checksum value
            */
            @property static uint getChecksum1()
            {
                return ptr.crc1;
            }

            /***********************************
            * Returns the second checksum value
            */
            @property static uint getChecksum2()
            {
                return ptr.crc2;
            }

            /***********************************
            * Returns the games 'good-name'.
            */
            @property static string getName()
            {
                return text(cast(const char*) ptr.name);
            }

            /***********************************
            * Returns the serial-number or game-id
            */
            @property static ushort getGameID()
            {
                auto val = ptr.gameID;
                return ((val & 0xFF) << 8) | (val >> 8);
            }

            /***********************************
            * Returns the country/region code
            */
            @property static char getCountry()
            {
                return ptr.countryCode;
            }

            /***********************************
            * Returns the revision number
            */
            @property static ubyte getRevision()
            {
                return ptr.revision;
            }

            /***********************************
            * Returns the revision number
            */
            @property static string getRelease()
            {
                return ptr.countryCode ~ 
                    text(ptr.revision);
            }
    }

export extern(C):

    // global variables
    static N64RomHeader* g_n64_rom_header;

    // non-native accessors
    N64RomHeader* crossemu_sdk_n64_header_get_ptr() { return g_n64_rom_header; }
    void crossemu_sdk_n64_header_set_ptr(N64RomHeader* address) { g_n64_rom_header = address; }
    
    /***********************************
    * Returns the cpu clock rate override (Value of 0 uses default)
    */
    @property uint crossemu_sdk_n64_header_clock_rate()
    {
        return N64RomHeader.getClockRate();
    }

    /***********************************
    * Returns the program counter
    */
    @property uint crossemu_sdk_n64_header_program_counter()
    {
        return N64RomHeader.getProgramCounter();
    }

    /***********************************
    * Returns the first checksum value
    */
    @property uint crossemu_sdk_n64_header_checksum1()
    {
        return N64RomHeader.getChecksum1();
    }

    /***********************************
    * Returns the second checksum value
    */
    @property uint crossemu_sdk_n64_header_checksum2()
    {
        return N64RomHeader.getChecksum2();
    }

    /***********************************
    * Returns the games 'good-name'.
    */
    @property const(char*) crossemu_sdk_n64_header_name()
    {
        return cast(const char*) N64RomHeader.ptr.name;
    }

    /***********************************
    * Returns the serial-number or game-id
    */
    @property ushort crossemu_sdk_n64_header_game_id()
    {
        return N64RomHeader.getGameID();
    }

    /***********************************
    * Returns the country/region code
    */
    @property char crossemu_sdk_n64_header_country()
    {
        return N64RomHeader.getCountry();
    }

    /***********************************
    * Returns the revision number
    */
    @property ubyte crossemu_sdk_n64_header_revision()
    {
        return N64RomHeader.getRevision();
    }

    /***********************************
    * Returns the revision number
    */
    @property const(char*) crossemu_sdk_n64_header_release()
    {
        import std.string : toStringz;
        return toStringz(N64RomHeader.getRelease());
    }