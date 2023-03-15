module crossemu.sdk.gd.crossemu_sdk;

import godot;
import godot.node;


class CrossEmu_Sdk : GodotScript!Node
{
    @Method String to_hex(Variant input)
    {
        import crossemu.sdk.utility : toHex;

        switch(input.type)
        {
            case Variant.Type.bool_:
                return String(toHex(input.as!ubyte));
            case Variant.Type.int_:
                return String(toHex(input.as!long));
            case Variant.Type.float_:
                return String(toHex(input.as!double));
            case Variant.Type.string:
                return String(toHex(input.toString()));
            default:
                return gs!"Type currently unsupported!";
        }
    }
}