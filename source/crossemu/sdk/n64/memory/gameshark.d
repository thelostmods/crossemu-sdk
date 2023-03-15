module crossemu.sdk.n64.memory.gameshark;

export extern(D):

    string gs2Code()(string code)
    {
        import crossemu.sdk.utility : toHex;
        import std.array : replace, split;
        import std.conv : to, text;
        import std.string : capitalize, splitLines, strip;

        string newCode = "import crossemu.sdk.n64.memory.rdram;\n";
        
        auto lines = splitLines(code);
        for (auto i = 0; i < lines.length; i++)
        {
            auto parts = lines[i].strip().replace("  ", " ").capitalize().split(" ");
            if (parts.length < 2 || parts[0].length != 8 || parts[1].length != 4) continue;

            auto lhand   = parts[0];
            auto rhand   = parts[1];
            auto cmd     = to!ubyte("0" ~ lhand[0],    16);
            auto type    = to!ubyte("0" ~ lhand[1],    16);
            auto addr    = to!uint("00" ~ lhand[2..8], 16);
            auto hexAddr = toHex(addr);
            auto value   = to!ushort(rhand, 16);
            auto hexVal  = toHex(value);

            // Get type modifier
            string t;
            switch (type)
            {
                default:
                case 0x0: case 0x2: t = "ubyte"; break;
                case 0x1: case 0x3: t = "ushort"; break;
            }
            
            // Command type check
            switch (cmd)
            {
                // Read commands
                case 0xD:
                    newCode ~= "if (N64RdRam.read!" ~ t ~ "(" ~ hexAddr ~ ")";
                    newCode ~= (type < 2) ? " == " : " != ";
                    newCode ~= hexVal ~ ")\n";
                    break;

                // Write commands
                case 0x8: case 0xA:
                    newCode ~= "N64RdRam.write!" ~ t ~ "(" ~ hexAddr ~ ", " ~ hexVal ~ ");\n";
                    break;

                case 0x5:
                    // Make sure we can actually do something
                    if (i >= lines.length) continue;

                    // Get next command stuff
                    auto _parts = lines[i+1].strip().replace("  ", " ").capitalize().split(" ");
                    if (_parts.length < 2 || _parts[0].length != 8 || _parts[1].length != 4) continue;

                    auto _lhand  = _parts[0];
                    auto _rhand  = _parts[1];
                    auto _cmd    = to!ubyte("0" ~ _lhand[0], 16);
                    auto _type   = to!ubyte("0" ~ _lhand[1], 16);
                    auto _addr   = to!uint("00" ~ _lhand[2..8], 16);
                    auto _value  = to!ushort(_rhand, 16);
                    auto _hexVal = toHex(_value);

                    // Get next command type modifier
                    string _t;
                    switch (_type)
                    {
                        default:
                        case 0x0: case 0x2: _t = "ubyte"; break;
                        case 0x1: case 0x3: _t = "ushort"; break;
                    }

                    // Make sure its using a write command
                    if (_cmd != 0x8 && _cmd != 0xA) continue;
                    
                    auto count  = to!ubyte(lhand[4..6], 16);
                    auto offset = to!ubyte(lhand[6..8], 16);
                    for (auto n = 0; n < count; n++)
                    {
                        auto _hexAddr = toHex(_addr + (n * offset));
                        
                        // Blit value
                        if (value == 0)
                            newCode ~= "N64RdRam.write!" ~ _t ~ "(" ~ _hexAddr ~ ", " ~ _hexVal ~ ");\n";

                        // Modify value
                        else
                        {
                            auto read = "N64RdRam.read!" ~ _t ~ "(" ~ _hexAddr ~ ")";
                            auto op = (type == 0) ? " + " : " - ";
                            auto write = "cast(" ~ _t ~ ") (" ~ text(value) ~ op ~ read ~ ")";
                            newCode ~= "N64RdRam.write!" ~ _t ~ "(" ~ _hexAddr ~ ", " ~ write ~ ");\n";
                        }
                    }

                    // Skip next command
                    i++;

                    break;
                
                // Invalid line
                default: continue;
            }
        }

        return newCode;
    }