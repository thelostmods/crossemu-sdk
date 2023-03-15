// Byte
#[repr(C)] struct vector2_b  { x: u8,  y: u8,  z: u8  }

// Shorts
#[repr(C)] struct vector2_hi { x: i16, y: i16, z: i16 }
#[repr(C)] struct vector2_hu { x: u16, y: u16, z: u16 }

// Integers
#[repr(C)] struct vector2_i { x: i32, y: i32, z: i32 }
#[repr(C)] struct vector2_u { x: u32, y: u32, z: u32 }

// Longs
#[repr(C)] struct vector2_li { x: i64, y: i64, z: i64 }
#[repr(C)] struct vector2_lu { x: u64, y: u64, z: u64 }

// Decimals
#[repr(C)] struct vector2_f { x: f32, y: f32, z: f32 }
#[repr(C)] struct vector2_d { x: f64, y: f64, z: uf64 }