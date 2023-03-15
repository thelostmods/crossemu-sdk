using System;
using System.Runtime.InteropServices;

namespace CrossEmu.Sdk.N64
{
    public static partial class Native
    {
        /// <summary>
        /// Reads a variable of int8, int16, int32, or int64 size.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="value">The variable pointer where data is being stored.</param>
        /// <param name="size">The size of the variable being passed.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_read_ptr_val")]
        public static extern bool VmemReadPtrVal(
            uint addr, uint ptr_offset, IntPtr value, UIntPtr size, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds
        );

        /// <summary>
        /// Reads a variable of int8, int16, int32, or int64 size.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="value">The variable pointer where data is being stored.</param>
        /// <param name="size">The size of the variable being passed.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_read_val")]
        public static extern bool VmemReadVal(
            uint addr, IntPtr value, UIntPtr size, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds
        );

        /// <summary>
        /// Reads a string at specified address.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_read_ptr_str")]
        public static extern IntPtr VmemReadPtrStr(
            uint addr, uint ptr_offset, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds
        );

        /// <summary>
        /// Reads a string at specified address.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_read_str")]
        public static extern IntPtr VmemReadStr(
            uint addr, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds
        );

        /// <summary>
        /// Reads an int8 sized array.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="size">The length of data to return.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_read_ptr_arr")]
        public static extern IntPtr VmemReadPtrArr(
            uint addr, uint ptr_offset, UIntPtr size, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds
        );

        /// <summary>
        /// Reads an int8 sized array.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="size">The length of data to return.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_read_arr")]
        public static extern IntPtr VmemReadArr(
            uint addr, UIntPtr size, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds
        );

        /// <summary>
        /// Reads an int8 sized array.
        /// This version does not re-order the mangled byte data from the emulator.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="size">The length of data to return.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_read_ptr_raw")]
        public static extern IntPtr VmemReadPtrRaw(
            uint addr, uint ptr_offset, UIntPtr size, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds
        );

        /// <summary>
        /// Reads an int8 sized array.
        /// This version does not re-order the mangled byte data from the emulator.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="size">The length of data to return.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_read_raw")]
        public static extern IntPtr VmemReadRaw(
            uint addr, UIntPtr size, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds
        );

        /// <summary>
        /// Writes a variable of int8, int16, int32, or int64 size.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="value">The variable pointer where data is being pulled.</param>
        /// <param name="size">The size of the variable being passed.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request.</param>
        /// <param name="memlog">A function to print the write request for logging.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_write_ptr_val")]
        public static extern bool VmemWritePtrVal(
            uint addr, uint ptr_offset, IntPtr value, UIntPtr size, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds,
            Action<uint, IntPtr, string> memlog
        );

        /// <summary>
        /// Writes a variable of int8, int16, int32, or int64 size.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="value">The variable pointer where data is being pulled.</param>
        /// <param name="size">The size of the variable being passed.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request.</param>
        /// <param name="memlog">A function to print the write request for logging.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_write_val")]
        public static extern bool VmemWriteVal(
            uint addr, IntPtr value, UIntPtr size, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds,
            Action<uint, IntPtr, string> memlog
        );

        /// <summary>
        /// Writes a string at specified address.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="value">The string data being passed.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request.</param>
        /// <param name="memlog">A function to print the write request for logging.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_write_ptr_str")]
        public static extern bool VmemWritePtrStr(
            uint addr, uint ptr_offset, string value, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds,
            Action<uint, IntPtr, string> memlog
        );

        /// <summary>
        /// Writes a string at specified address.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="value">The string data being passed.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request.</param>
        /// <param name="memlog">A function to print the write request for logging.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_write_str")]
        public static extern bool VmemWriteStr(
            uint addr, string value, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds,
            Action<uint, IntPtr, string> memlog
        );

        /// <summary>
        /// Writes an int8 sized array.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="value">The variable pointer where data is being pulled.</param>
        /// <param name="size">The size of the data being passed.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request.</param>
        /// <param name="memlog">A function to print the write request for logging.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_write_ptr_arr")]
        public static extern bool VmemWritePtrArr(
            uint addr, uint ptr_offset, IntPtr value, UIntPtr size, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds,
            Action<uint, IntPtr, string> memlog
        );
        
        /// <summary>
        /// Writes an int8 sized array.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="value">The variable pointer where data is being pulled.</param>
        /// <param name="size">The size of the data being passed.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request.</param>
        /// <param name="memlog">A function to print the write request for logging.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_write_arr")]
        public static extern bool VmemWriteArr(
            uint addr, IntPtr value, UIntPtr size, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds,
            Action<uint, IntPtr, string> memlog
        );
        
        /// <summary>
        /// Writes an int8 sized array.
        /// This version does not re-order the mangled byte data for the emulator.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="ptr_offset">The offset inside the (assumed) struct that addr points to.</param>
        /// <param name="value">The variable pointer where data is being pulled.</param>
        /// <param name="size">The size of the data being passed.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request.</param>
        /// <param name="memlog">A function to print the write request for logging.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_write_ptr_raw")]
        public static extern bool VmemWritePtrRaw(
            uint addr, uint ptr_offset, IntPtr value, UIntPtr size, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds,
            Action<uint, IntPtr, string> memlog
        );

        /// <summary>
        /// Writes an int8 sized array.
        /// This version does not re-order the mangled byte data for the emulator.
        /// </summary>
        ///
        /// <param name="addr">The location where memory starts.</param>
        /// <param name="value">The variable pointer where data is being pulled.</param>
        /// <param name="size">The size of the data being passed.</param>
        ///
        /// <param name="vmem_ptr">A pointer to the virtual memory type.</param>
        /// <param name="check_bounds">A function to check memory bounds with address request.</param>
        /// <param name="memlog">A function to print the write request for logging.</param>
        [DllImport("crossemu-sdk", CallingConvention = CallingConvention.StdCall,
            EntryPoint = "crossemu_sdk_n64_vmem_write_raw")]
        public static extern bool VmemWriteRaw(
            uint addr, IntPtr value, UIntPtr size, IntPtr vmem_ptr,
            Func<bool, uint, UIntPtr> check_bounds,
            Action<uint, IntPtr, string> memlog
        );
    }
}