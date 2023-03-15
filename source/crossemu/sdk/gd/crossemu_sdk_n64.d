module crossemu.sdk.gd.crossemu_sdk_n64;

import godot;
import godot.refcounted;

import crossemu.sdk.gd.gd_utils;

import crossemu.sdk.n64;

class CrossEmu_Sdk_N64 : GodotScript!RefCounted
{
    /***********************
    |**  Types (Enums)
    \*****/
    mixin(gdEnum!("Button", N64Button));
    mixin(gdEnum!("GameID", N64GameID));

    /***********************
    |**  Header Methods
    \*****/

    @Method static long   header_clock_rate()      { return N64RomHeader.getClockRate(); }
    @Method static long   header_program_counter() { return N64RomHeader.getProgramCounter(); }
    @Method static long   header_checksum1()       { return N64RomHeader.getChecksum1(); }
    @Method static long   header_checksum2()       { return N64RomHeader.getChecksum2(); }
    @Method static String header_name()            { return String(N64RomHeader.getName()); }
    @Method static long   header_game_id()         { return N64RomHeader.getGameID(); }
    @Method static long   header_country()         { return N64RomHeader.getCountry(); }
    @Method static long   header_revision()        { return N64RomHeader.getRevision(); }
    @Method static String header_release()         { return String(N64RomHeader.getRelease()); }

    /***********************
    |**  RdRam Methods
    \*****/

    @Method static long   rdram_read_ptr_u8 (uint address, uint ptr_offset) { return N64RdRam.readPtr!ubyte(address, ptr_offset); }
    @Method static long   rdram_read_ptr_i16(uint address, uint ptr_offset) { return N64RdRam.readPtr!short(address, ptr_offset); }
    @Method static long   rdram_read_ptr_u16(uint address, uint ptr_offset) { return N64RdRam.readPtr!ushort(address, ptr_offset); }
    @Method static long   rdram_read_ptr_i32(uint address, uint ptr_offset) { return N64RdRam.readPtr!int(address, ptr_offset); }
    @Method static long   rdram_read_ptr_u32(uint address, uint ptr_offset) { return N64RdRam.readPtr!uint(address, ptr_offset); }
    @Method static double rdram_read_ptr_f32(uint address, uint ptr_offset) { return N64RdRam.readPtr!float(address, ptr_offset); }
    @Method static long   rdram_read_ptr_i64(uint address, uint ptr_offset) { return N64RdRam.readPtr!long(address, ptr_offset); }
    @Method static long   rdram_read_ptr_u64(uint address, uint ptr_offset) { return N64RdRam.readPtr!ulong(address, ptr_offset); }
    @Method static double rdram_read_ptr_f64(uint address, uint ptr_offset) { return N64RdRam.readPtr!double(address, ptr_offset); }
    @Method static String rdram_read_ptr_str(uint address, uint ptr_offset) { return String(N64RdRam.readPtr!string(address, ptr_offset)); }
    // @Method static PackedByteArray rdram_read_ptr_arr(uint address, uint ptr_offset, size_t size)
    // {
    //     return PackedByteArray(N64RdRam.readPtr!ubyte(address, ptr_offset, size));
    // }
    // @Method static PackedByteArray rdram_read_ptr_raw(uint address, uint ptr_offset, size_t size)
    // {
    //     return PackedByteArray(N64RdRam.readRawPtr!ubyte(address, ptr_offset, size));
    // }

    @Method static long   rdram_read_u8 (uint address) { return N64RdRam.read!ubyte(address); }
    @Method static long   rdram_read_i16(uint address) { return N64RdRam.read!short(address); }
    @Method static long   rdram_read_u16(uint address) { return N64RdRam.read!ushort(address); }
    @Method static long   rdram_read_i32(uint address) { return N64RdRam.read!int(address); }
    @Method static long   rdram_read_u32(uint address) { return N64RdRam.read!uint(address); }
    @Method static double rdram_read_f32(uint address) { return N64RdRam.read!float(address); }
    @Method static long   rdram_read_i64(uint address) { return N64RdRam.read!long(address); }
    @Method static long   rdram_read_u64(uint address) { return N64RdRam.read!ulong(address); }
    @Method static double rdram_read_f64(uint address) { return N64RdRam.read!double(address); }
    @Method static String rdram_read_str(uint address) { return String(N64RdRam.read!string(address)); }
    // @Method static PackedByteArray rdram_read_arr(uint address, size_t size)
    // {
    //     return PackedByteArray(N64RdRam.read!ubyte(address, size));
    // }
    // @Method static PackedByteArray rdram_read_raw(uint address, size_t size)
    // {
    //     return PackedByteArray(N64RdRam.readRaw!ubyte(address, size));
    // }

    @Method static bool rdram_write_ptr_u8 (uint address, uint ptr_offset, long   value) { return N64RdRam.writePtr(address, ptr_offset, cast(ubyte) value); }
    @Method static bool rdram_write_ptr_i16(uint address, uint ptr_offset, long   value) { return N64RdRam.writePtr(address, ptr_offset, cast(short) value); }
    @Method static bool rdram_write_ptr_u16(uint address, uint ptr_offset, long   value) { return N64RdRam.writePtr(address, ptr_offset, cast(ushort) value); }
    @Method static bool rdram_write_ptr_i32(uint address, uint ptr_offset, long   value) { return N64RdRam.writePtr(address, ptr_offset, cast(int) value); }
    @Method static bool rdram_write_ptr_u32(uint address, uint ptr_offset, long   value) { return N64RdRam.writePtr(address, ptr_offset, cast(uint) value); }
    @Method static bool rdram_write_ptr_f32(uint address, uint ptr_offset, double value) { return N64RdRam.writePtr(address, ptr_offset, cast(float) value); }
    @Method static bool rdram_write_ptr_i64(uint address, uint ptr_offset, long   value) { return N64RdRam.writePtr(address, ptr_offset, cast(long) value); }
    @Method static bool rdram_write_ptr_u64(uint address, uint ptr_offset, long   value) { return N64RdRam.writePtr(address, ptr_offset, cast(ulong) value); }
    @Method static bool rdram_write_ptr_f64(uint address, uint ptr_offset, double value) { return N64RdRam.writePtr(address, ptr_offset, cast(double) value); }
    @Method static bool rdram_write_ptr_str(uint address, uint ptr_offset, String value) { return N64RdRam.writePtr(address, ptr_offset, value.toString()); }
    // @Method static bool rdram_write_ptr_arr(uint address, uint ptr_offset, PackedByteArray value)
    // {
    //     return N64RdRam.writePtr(address, ptr_offset, value.);
    // }
    // @Method static bool rdram_write_ptr_raw(uint address, uint ptr_offset, PackedByteArray value)
    // {
    //     return N64RdRam.writeRawPtr(address, ptr_offset, value.);
    // }

    @Method static bool rdram_write_u8 (uint address, long   value) { return N64RdRam.write(address, cast(ubyte) value); }
    @Method static bool rdram_write_i16(uint address, long   value) { return N64RdRam.write(address, cast(short) value); }
    @Method static bool rdram_write_u16(uint address, long   value) { return N64RdRam.write(address, cast(ushort) value); }
    @Method static bool rdram_write_i32(uint address, long   value) { return N64RdRam.write(address, cast(int) value); }
    @Method static bool rdram_write_u32(uint address, long   value) { return N64RdRam.write(address, cast(uint) value); }
    @Method static bool rdram_write_f32(uint address, double value) { return N64RdRam.write(address, cast(float) value); }
    @Method static bool rdram_write_i64(uint address, long   value) { return N64RdRam.write(address, cast(long) value); }
    @Method static bool rdram_write_u64(uint address, long   value) { return N64RdRam.write(address, cast(ulong) value); }
    @Method static bool rdram_write_f64(uint address, double value) { return N64RdRam.write(address, cast(double) value); }
    @Method static bool rdram_write_str(uint address, String value) { return N64RdRam.write(address, value.toString()); }
    // @Method static bool rdram_write_arr(uint address, PackedByteArray value)
    // {
    //     return N64RdRam.write(address, value.);
    // }
    // @Method static bool rdram_write_raw(uint address, PackedByteArray value)
    // {
    //     return N64RdRam.writeRaw(address, value.);
    // }

    /***********************
    |**  Rom Methods
    \*****/

    @Method static long   rom_read_ptr_u8 (uint address, uint ptr_offset) { return N64Rom.readPtr!ubyte(address, ptr_offset); }
    @Method static long   rom_read_ptr_i16(uint address, uint ptr_offset) { return N64Rom.readPtr!short(address, ptr_offset); }
    @Method static long   rom_read_ptr_u16(uint address, uint ptr_offset) { return N64Rom.readPtr!ushort(address, ptr_offset); }
    @Method static long   rom_read_ptr_i32(uint address, uint ptr_offset) { return N64Rom.readPtr!int(address, ptr_offset); }
    @Method static long   rom_read_ptr_u32(uint address, uint ptr_offset) { return N64Rom.readPtr!uint(address, ptr_offset); }
    @Method static double rom_read_ptr_f32(uint address, uint ptr_offset) { return N64Rom.readPtr!float(address, ptr_offset); }
    @Method static long   rom_read_ptr_i64(uint address, uint ptr_offset) { return N64Rom.readPtr!long(address, ptr_offset); }
    @Method static long   rom_read_ptr_u64(uint address, uint ptr_offset) { return N64Rom.readPtr!ulong(address, ptr_offset); }
    @Method static double rom_read_ptr_f64(uint address, uint ptr_offset) { return N64Rom.readPtr!double(address, ptr_offset); }
    @Method static String rom_read_ptr_str(uint address, uint ptr_offset) { return String(N64Rom.readPtr!string(address, ptr_offset)); }
    // @Method static PackedByteArray rom_read_ptr_arr(uint address, uint ptr_offset, size_t size)
    // {
    //     return PackedByteArray(N64Rom.readPtr!ubyte(address, ptr_offset, size));
    // }
    // @Method static PackedByteArray rom_read_ptr_raw(uint address, uint ptr_offset, size_t size)
    // {
    //     return PackedByteArray(N64Rom.readRawPtr!ubyte(address, ptr_offset, size));
    // }

    @Method static long   rom_read_u8 (uint address) { return N64Rom.read!ubyte(address); }
    @Method static long   rom_read_i16(uint address) { return N64Rom.read!short(address); }
    @Method static long   rom_read_u16(uint address) { return N64Rom.read!ushort(address); }
    @Method static long   rom_read_i32(uint address) { return N64Rom.read!int(address); }
    @Method static long   rom_read_u32(uint address) { return N64Rom.read!uint(address); }
    @Method static double rom_read_f32(uint address) { return N64Rom.read!float(address); }
    @Method static long   rom_read_i64(uint address) { return N64Rom.read!long(address); }
    @Method static long   rom_read_u64(uint address) { return N64Rom.read!ulong(address); }
    @Method static double rom_read_f64(uint address) { return N64Rom.read!double(address); }
    @Method static String rom_read_str(uint address) { return String(N64Rom.read!string(address)); }
    // @Method static PackedByteArray rom_read_arr(uint address, size_t size)
    // {
    //     return PackedByteArray(N64Rom.read!ubyte(address, size));
    // }
    // @Method static PackedByteArray rom_read_raw(uint address, size_t size)
    // {
    //     return PackedByteArray(N64Rom.readRaw!ubyte(address, size));
    // }

    @Method static bool rom_write_ptr_u8 (uint address, uint ptr_offset, long   value) { return N64Rom.writePtr(address, ptr_offset, cast(ubyte) value); }
    @Method static bool rom_write_ptr_i16(uint address, uint ptr_offset, long   value) { return N64Rom.writePtr(address, ptr_offset, cast(short) value); }
    @Method static bool rom_write_ptr_u16(uint address, uint ptr_offset, long   value) { return N64Rom.writePtr(address, ptr_offset, cast(ushort) value); }
    @Method static bool rom_write_ptr_i32(uint address, uint ptr_offset, long   value) { return N64Rom.writePtr(address, ptr_offset, cast(int) value); }
    @Method static bool rom_write_ptr_u32(uint address, uint ptr_offset, long   value) { return N64Rom.writePtr(address, ptr_offset, cast(uint) value); }
    @Method static bool rom_write_ptr_f32(uint address, uint ptr_offset, double value) { return N64Rom.writePtr(address, ptr_offset, cast(float) value); }
    @Method static bool rom_write_ptr_i64(uint address, uint ptr_offset, long   value) { return N64Rom.writePtr(address, ptr_offset, cast(long) value); }
    @Method static bool rom_write_ptr_u64(uint address, uint ptr_offset, long   value) { return N64Rom.writePtr(address, ptr_offset, cast(ulong) value); }
    @Method static bool rom_write_ptr_f64(uint address, uint ptr_offset, double value) { return N64Rom.writePtr(address, ptr_offset, cast(double) value); }
    @Method static bool rom_write_ptr_str(uint address, uint ptr_offset, String value) { return N64Rom.writePtr(address, ptr_offset, value.toString()); }
    // @Method static bool rom_write_ptr_arr(uint address, uint ptr_offset, PackedByteArray value)
    // {
    //     return N64Rom.writePtr(address, ptr_offset, value.);
    // }
    // @Method static bool rom_write_ptr_raw(uint address, uint ptr_offset, PackedByteArray value)
    // {
    //     return N64Rom.writeRawPtr(address, ptr_offset, value.);
    // }

    @Method static bool rom_write_u8 (uint address, long   value) { return N64Rom.write(address, cast(ubyte) value); }
    @Method static bool rom_write_i16(uint address, long   value) { return N64Rom.write(address, cast(short) value); }
    @Method static bool rom_write_u16(uint address, long   value) { return N64Rom.write(address, cast(ushort) value); }
    @Method static bool rom_write_i32(uint address, long   value) { return N64Rom.write(address, cast(int) value); }
    @Method static bool rom_write_u32(uint address, long   value) { return N64Rom.write(address, cast(uint) value); }
    @Method static bool rom_write_f32(uint address, double value) { return N64Rom.write(address, cast(float) value); }
    @Method static bool rom_write_i64(uint address, long   value) { return N64Rom.write(address, cast(long) value); }
    @Method static bool rom_write_u64(uint address, long   value) { return N64Rom.write(address, cast(ulong) value); }
    @Method static bool rom_write_f64(uint address, double value) { return N64Rom.write(address, cast(double) value); }
    @Method static bool rom_write_str(uint address, String value) { return N64Rom.write(address, value.toString()); }
    // @Method static bool rom_write_arr(uint address, PackedByteArray value)
    // {
    //     return N64Rom.write(address, value.);
    // }
    // @Method static bool rom_write_raw(uint address, PackedByteArray value)
    // {
    //     return N64Rom.writeRaw(address, value.);
    // }
}