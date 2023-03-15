using System;
using System.Runtime.InteropServices;

namespace CrossEmu.Sdk.N64
{
    /// <summary>
    /// Utility system for reading the components in the rom header
    /// </summary>
    public unsafe struct N64RomHeader
    {
        public byte       pi_bsb_dom1_lat_reg; // 0x00
        public byte       pi_bsd_dom1_pgs_reg; // 0x01
        public byte       pi_bsd_dom1_pwd_reg; // 0x02
        public byte       pi_bsb_dom1_pgs_reg; // 0x03
        public uint       clockRate;           // 0x04
        public uint       programCounter;      // 0x08
        public uint       releasePtr;          // 0x0C
        public uint       crc1;                // 0x10
        public uint       crc2;                // 0x14
        public fixed uint unk1[2];             // 0x18
        public fixed char name[20];            // 0x20
        public uint       unk2;                // 0x34
        public uint       mediaFormat;         // 0x38
        public ushort     gameID;              // 0x3C
        public char       countryCode;         // 0x3E
        public byte       revision;            // 0x3F


        // static contents


        public static IntPtr Ptr
        {
            get { return Native.HeaderGetPtr(); }
            set { Native.HeaderSetPtr(value); }
        }

        /// <summary>
        /// Returns the cpu clock rate override (Value of 0 uses default)
        /// </summary>
        public static uint GetClockRate() => Native.HeaderClockRate();

        /// <summary>
        /// Returns the program counter
        /// </summary>
        public static uint GetProgramCounter() => Native.HeaderProgramCounter();

        /// <summary>
        /// Returns the first checksum value
        /// </summary>
        public static uint GetChecksum1() => Native.HeaderChecksum1();

        /// <summary>
        /// Returns the second checksum value
        /// </summary>
        public static uint GetChecksum2() => Native.HeaderChecksum2();

        /// <summary>
        /// Returns the games 'good-name'.
        /// </summary>
        public static string GetName() => Marshal.PtrToStringAuto(Native.HeaderName())!;

        /// <summary>
        /// Returns the serial-number or game-id
        /// </summary>
        public static ushort GetGameID() => Native.HeaderGameID();

        /// <summary>
        /// Returns the country/region code
        /// </summary>
        public static char GetCountry() => Native.HeaderCountry();

        /// <summary>
        /// Returns the revision number
        /// </summary>
        public static byte GetRevision() => Native.HeaderRevision();

        /// <summary>
        /// Returns the revision number
        /// </summary>
        public static string GetRelease() => Marshal.PtrToStringAuto(Native.HeaderRelease())!;
    }
    
    public static partial class Native
    {
        // non-native accessors
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_header_get_ptr")]
        public static extern IntPtr  HeaderGetPtr();

        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_header_set_ptr")]
        public static extern void   HeaderSetPtr(IntPtr address);

        /// <summary>
        /// Returns the cpu clock rate override (Value of 0 uses default)
        /// </summary>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_header_clock_rate")]
        public static extern uint HeaderClockRate();

        /// <summary>
        /// Returns the program counter
        /// </summary>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_header_program_counter")]
        public static extern uint HeaderProgramCounter();

        /// <summary>
        /// Returns the first checksum value
        /// </summary>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_header_checksum1")]
        public static extern uint HeaderChecksum1();

        /// <summary>
        /// Returns the second checksum value
        /// </summary>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_header_checksum2")]
        public static extern uint HeaderChecksum2();

        /// <summary>
        /// Returns the games 'good-name'.
        /// </summary>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_header_name")]
        public static extern IntPtr HeaderName();

        /// <summary>
        /// Returns the serial-number or game-id
        /// </summary>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_header_game_id")]
        public static extern ushort HeaderGameID();

        /// <summary>
        /// Returns the country/region code
        /// </summary>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_header_country")]
        public static extern char HeaderCountry();

        /// <summary>
        /// Returns the revision number
        /// </summary>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_header_revision")]
        public static extern byte HeaderRevision();

        /// <summary>
        /// Returns the revision number
        /// </summary>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_header_release")]
        public static extern IntPtr HeaderRelease();
    }
}