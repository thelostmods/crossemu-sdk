using System;
using System.Linq;
using System.Runtime.InteropServices;

namespace CrossEmu.Sdk
{
    public static class Utility
    {
        public static string ToHex(byte input) { return input.ToString("X2"); }
        public static string ToHex(sbyte input) { return input.ToString("X2"); }
        public static string ToHex(short input) { return input.ToString("X4"); }
        public static string ToHex(ushort input) { return input.ToString("X4"); }
        public static string ToHex(int input) { return input.ToString("X8"); }
        public static string ToHex(uint input) { return input.ToString("X8"); }
        public static string ToHex(long input) { return input.ToString("X16"); }
        public static string ToHex(ulong input) { return input.ToString("X16"); }
        public static string ToHex(float input) { return input.ToString("X8"); }
        public static string ToHex(double input) { return input.ToString("X16"); }
        public static string ToHex(char input) { return input.ToString(); }
        public static string ToHex(string input) { return input; }
        public static string ToHex(byte[] input)
        {
            return input.Aggregate("", (current, t) => current + t.ToString("X2"));
        }
    }

    public static partial class Native
    {
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_throw_error")]
        public static extern void  ThrowError(string error);

        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_to_hex_i08")]
        public static extern IntPtr ToHexI08(IntPtr input);

        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_to_hex_i16")]
        public static extern IntPtr ToHexI16(IntPtr input);

        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_to_hex_i32")]
        public static extern IntPtr ToHexI32(IntPtr input);

        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_to_hex_i64")]
        public static extern IntPtr ToHexI64(IntPtr input);

        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_to_hex_f32")]
        public static extern IntPtr ToHexF32(IntPtr input);

        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_to_hex_f64")]
        public static extern IntPtr ToHexF64(IntPtr input);

        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_to_hex_str")]
        public static extern IntPtr ToHexStr(IntPtr input);

        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_to_hex_arr")]
        public static extern IntPtr ToHexArr(IntPtr input);
    }
}