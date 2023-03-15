import godot;

import crossemu.sdk.gd.crossemu_sdk;
import crossemu.sdk.gd.crossemu_sdk_math;
import crossemu.sdk.gd.crossemu_sdk_n64;

// register classes, initialize and terminate D runtime, only one per plugin
mixin GodotNativeLibrary!(
    // this is a name prefix of the plugin to be acessible inside godot
    // it must match the prefix in .gdextension file:
    //     entry_symbol = "crossemu_sdk_gdextension_entry"
    "crossemu_sdk", 

    // here goes the list of classes you would like to expose in godot
    CrossEmu_Sdk,
    CrossEmu_Sdk_Math,
    CrossEmu_Sdk_N64
);