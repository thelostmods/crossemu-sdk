using System;
using System.Runtime.InteropServices;
using Utils = CrossEmu.Sdk.Utility;

namespace CrossEmu.Sdk.N64
{
    /// <summary>
    /// Utility system containing rom read/write functions
    /// Instanced: A uint that references rom space
    /// </summary>
    public struct N64Rom
    {
        public uint Address;
        public N64Rom(uint addr) { this.Address = addr; }

        public static implicit operator uint(N64Rom addr) => addr.Address;
        public static implicit operator N64Rom(uint addr) => new N64Rom(addr);

        public override string ToString() { return Utils.ToHex(Address); }


        // static contents


        public static IntPtr Ptr
        {
            get { return Native.RomGetPtr(); }
            set { Native.RomSetPtr(value); }
        }

        public static UIntPtr Len
        {
            get { return Native.RomGetLen(); }
            set { Native.RomSetLen(value); }
        }

        public static bool Logging
        {
            get { return Native.RomGetLogging(); }
            set { Native.RomSetLogging(value); }
        }

        /// <summary>
        /// Reads a variable of the specified type.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptrOffset">The offset inside the (assumed) struct that addr points to.</param>
        public static T ReadPtr<T>(uint addr, uint ptrOffset) where T : new()
        {
            return Read<T>(Read<uint>(addr) + ptrOffset);
        }
            
        /// <summary>
        /// Reads a variable of the specified type.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        public static T Read<T>(uint addr) where T : new()
        {
            if (typeof(T) == typeof(string))
            {
                return (T)(object) Marshal.PtrToStringAuto(Native.RomReadStr(addr))!;
            }
            switch (Type.GetTypeCode(typeof(T)))
            {
                case TypeCode.Byte:    case TypeCode.SByte:
                case TypeCode.UInt16:  case TypeCode.UInt32: case TypeCode.UInt64:
                case TypeCode.Int16:   case TypeCode.Int32:  case TypeCode.Int64:
                case TypeCode.Decimal: case TypeCode.Double: case TypeCode.Single:
                    T value = new T();

                    GCHandle handle = GCHandle.Alloc(value, GCHandleType.Pinned);
                    IntPtr ptr = handle.AddrOfPinnedObject();

                    Native.RomReadVal(addr, ptr, (UIntPtr) Marshal.SizeOf(default(T)));
                    handle.Free();

                    return value;

                default:
                    throw new Exception("CrossEmu.Sdk.N64 [N64Rom.Read]: Requested type invalid!");
            }
        }

        /// <summary>
        /// Reads an int8 sized array.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptrOffset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="size">The amount of data (array.length) to return.</param>
        public static byte[] ReadPtr(uint addr, uint ptrOffset, UIntPtr size)
        {
            return Read(Read<uint>(addr) + ptrOffset, size);
        }

        /// <summary>
        /// Reads an int8 sized array.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="size">The amount of data (array.length) to return.</param>
        public static byte[] Read(uint addr, UIntPtr size)
        {
            IntPtr ptr = Native.RomReadArr(addr, size);
            if (ptr == IntPtr.Zero) return new byte[0];

            byte[] value = new byte[size];
            Marshal.Copy(ptr, value, 0, (int) size);
            return value;
        }

        /// <summary>
        /// Reads an int8 sized array.
        /// This version does not re-order the mangled byte data from the emulator.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptrOffset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="size">The amount of data (array.length) to return.</param>
        public static byte[] ReadRawPtr(uint addr, uint ptrOffset, UIntPtr size)
        {
            return ReadRaw(Read<uint>(addr) + ptrOffset, size);
        }

        /// <summary>
        /// Reads an int8 sized array.
        /// This version does not re-order the mangled byte data from the emulator.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="size">The amount of data (array.length) to return.</param>
        public static byte[] ReadRaw(uint addr, UIntPtr size)
        {
            IntPtr ptr = Native.RomReadRaw(addr, size);
            if (ptr == IntPtr.Zero) return new byte[0];

            byte[] value = new byte[size];
            Marshal.Copy(ptr, value, 0, (int) size);
            return value;
        }

        /// <summary>
        /// Writes a variable of the specified type.
        /// </summary>
        ///
        /// <param name="addr">The location where a pointer to your data starts.</param>
        /// <param name="ptrOffset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="value">The data being written in.</param>
        public static bool WritePtr<T>(uint addr, uint ptrOffset, T value) where T : new()
        {
            return Write<T>(Read<uint>(addr) + ptrOffset, value);
        }

        /// <summary>
        /// Writes a variable of the specified type.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="value">The data being written in.</param>
        public static bool Write<T>(uint addr, T value) where T : new()
        {
            if (typeof(T) == typeof(string))
            {
                if (value == null) return false;
                return Native.RomWriteStr(addr, (string)(object)value);
            }
            switch (Type.GetTypeCode(typeof(T)))
            {
                case TypeCode.Byte:    case TypeCode.SByte:
                case TypeCode.UInt16:  case TypeCode.UInt32: case TypeCode.UInt64:
                case TypeCode.Int16:   case TypeCode.Int32:  case TypeCode.Int64:
                case TypeCode.Decimal: case TypeCode.Double: case TypeCode.Single:
                    GCHandle handle = GCHandle.Alloc(value, GCHandleType.Pinned);
                    IntPtr ptr = handle.AddrOfPinnedObject();

                    bool success = Native.RomWriteVal(addr, ptr, (UIntPtr) Marshal.SizeOf(default(T)));
                    handle.Free();

                    return success;
                        
                default:
                    throw new Exception("CrossEmu.Sdk.N64 [N64Rom.Write]: Requested type invalid!");
            }
        }
            
        /// <summary>
        /// Writes an int8 sized array.
        /// </summary>
        ///
        /// <param name="addr">The location where a pointer to your data starts.</param>
        /// <param name="ptrOffset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="value">The data being written in.</param>
        public static bool WritePtr(uint addr, uint ptrOffset, byte[] value)
        {
            return Write(Read<uint>(addr) + ptrOffset, value);
        }

        /// <summary>
        /// Writes an int8 sized array.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="value">The data being written in.</param>
        public static bool Write(uint addr, byte[] value)
        {
            GCHandle handle = GCHandle.Alloc(value, GCHandleType.Pinned);
            IntPtr ptr = handle.AddrOfPinnedObject();

            bool success = Native.RomWriteArr(addr, ptr, (UIntPtr) value.Length);
            handle.Free();

            return success;
        }

        /// <summary>
        /// Writes an int8 sized array.
        /// This version does not re-order the mangled byte data for the emulator.
        /// </summary>
        ///
        /// <param name="addr">The location where a pointer to your data starts.</param>
        /// <param name="ptrOffset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="value">The data being written in.</param>
        public static bool WriteRawPtr(uint addr, uint ptrOffset, byte[] value)
        {
            return WriteRaw(Read<uint>(addr) + ptrOffset, value);
        }

        /// <summary>
        /// Writes an int8 sized array.
        /// This version does not re-order the mangled byte data for the emulator.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="value">The data being written in.</param>
        public static bool WriteRaw(uint addr, byte[] value)
        {
            GCHandle handle = GCHandle.Alloc(value, GCHandleType.Pinned);
            IntPtr ptr = handle.AddrOfPinnedObject();

            bool success = Native.RomWriteRaw(addr, ptr, (UIntPtr) value.Length);
            handle.Free();

            return success;
        }
    }
    
    public static partial class Native
    {
        // non-native accessors
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_get_ptr")]
        public static extern IntPtr  RomGetPtr();

        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_set_ptr")]
        public static extern void   RomSetPtr(IntPtr address);
        
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_get_len")]
        public static extern UIntPtr RomGetLen();

        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_set_len")]
        public static extern void   RomSetLen(UIntPtr size);
        
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_get_logging")]
        public static extern bool   RomGetLogging();

        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_set_logging")]
        public static extern void   RomSetLogging(bool enabled);

        // vmem callbacks
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_check_bounds")]
        public static extern bool RomCheckBounds(uint addr, UIntPtr size);

        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_memlog")]
        public static extern void RomMemLog(uint addr, IntPtr value, string type);

        /// <summary>
        /// Reads a variable of int8, int16, int32, or int64 size.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="value">The variable pointer where data is being stored.</param>
        /// <param name="size">The size of the variable being passed.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_read_ptr_val")]
        public static extern bool RomReadPtrVal(uint addr, uint ptr_offset, IntPtr value, UIntPtr size);

        /// <summary>
        /// Reads a variable of int8, int16, int32, or int64 size.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="value">The variable pointer where data is being stored.</param>
        /// <param name="size">The size of the variable being passed.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_read_val")]
        public static extern bool RomReadVal(uint addr, IntPtr value, UIntPtr size);

        /// <summary>
        /// Reads a string at specified address.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_read_ptr_str")]
        public static extern IntPtr RomReadPtrStr(uint addr, uint ptr_offset);

        /// <summary>
        /// Reads a string at specified address.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_read_str")]
        public static extern IntPtr RomReadStr(uint addr);

        /// <summary>
        /// Reads an int8 sized array.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="size">The length of data to return.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_read_ptr_arr")]
        public static extern IntPtr RomReadPtrArr(uint addr, uint ptr_offset, UIntPtr size);

        /// <summary>
        /// Reads an int8 sized array.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="size">The length of data to return.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_read_arr")]
        public static extern IntPtr RomReadArr(uint addr, UIntPtr size);

        /// <summary>
        /// Reads an int8 sized array.
        /// This version does not re-order the mangled byte data from the emulator.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="size">The length of data to return.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_read_ptr_raw")]
        public static extern IntPtr RomReadPtrRaw(uint addr, uint ptr_offset, UIntPtr size);

        /// <summary>
        /// Reads an int8 sized array.
        /// This version does not re-order the mangled byte data from the emulator.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="size">The length of data to return.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_read_raw")]
        public static extern IntPtr RomReadRaw(uint addr, UIntPtr size);

        /// <summary>
        /// Writes a variable of int8, int16, int32, or int64 size.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="value">The variable pointer where data is being pulled.</param>
        /// <param name="size">The size of the variable being passed.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_write_ptr_val")]
        public static extern bool RomWritePtrVal(uint addr, uint ptr_offset, IntPtr value, UIntPtr size);

        /// <summary>
        /// Writes a variable of int8, int16, int32, or int64 size.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="value">The variable pointer where data is being pulled.</param>
        /// <param name="size">The size of the variable being passed.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_write_val")]
        public static extern bool RomWriteVal(uint addr, IntPtr value, UIntPtr size);

        /// <summary>
        /// Writes a string at specified address.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="value">The string data being passed.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_write_ptr_str")]
        public static extern bool RomWritePtrStr(uint addr, uint ptr_offset, string value);

        /// <summary>
        /// Writes a string at specified address.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="value">The string data being passed.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_write_str")]
        public static extern bool RomWriteStr(uint addr, string value);

        /// <summary>
        /// Writes an int8 sized array.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="value">The variable pointer where data is being pulled.</param>
        /// <param name="size">The size of the data being passed.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_write_ptr_arr")]
        public static extern bool RomWritePtrArr(uint addr, uint ptr_offset, IntPtr value, UIntPtr size);
        
        /// <summary>
        /// Writes an int8 sized array.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="value">The variable pointer where data is being pulled.</param>
        /// <param name="size">The size of the data being passed.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_write_arr")]
        public static extern bool RomWriteArr(uint addr, IntPtr value, UIntPtr size);
        
        /// <summary>
        /// Writes an int8 sized array.
        /// This version does not re-order the mangled byte data for the emulator.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="value">The variable pointer where data is being pulled.</param>
        /// <param name="size">The size of the data being passed.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_write_ptr_raw")]
        public static extern bool RomWritePtrRaw(uint addr, uint ptr_offset, IntPtr value, UIntPtr size);

        /// <summary>
        /// Writes an int8 sized array.
        /// This version does not re-order the mangled byte data for the emulator.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="value">The variable pointer where data is being pulled.</param>
        /// <param name="size">The size of the data being passed.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_rom_write_raw")]
        public static extern bool RomWriteRaw(uint addr, IntPtr value, UIntPtr size);
    }
}