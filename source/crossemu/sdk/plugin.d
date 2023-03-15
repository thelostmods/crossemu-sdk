module crossemu.sdk.plugin;

template pluginInfo(string _name, string _description, string _authors, uint _version, bool _reqRestart)
{
    import std.conv : text;
    const char[] pluginInfo = "
        export extern (C) {
            const(char*) plugin_name()              { return \"" ~ _name ~ "\"; }
            const(char*) plugin_description()       { return \"" ~ _description ~ "\"; }
            const(char*) plugin_authors()           { return \"" ~ _authors ~ "\"; }
            uint         plugin_version()           { return " ~ text(_version) ~ "; }
            bool         plugin_req_restart()       { return " ~ text(_reqRestart) ~ "; }

            bool         plugin_initialize()        { return initialize(); }
            void         plugin_terminate()         { terminate(); }
            void         plugin_on_first_frame()    { onFirstFrame(); }
            void         plugin_on_tick(uint frame) { onTick(frame); }
        }
    ";
}