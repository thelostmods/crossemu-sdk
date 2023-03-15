module crossemu.sdk.gd.gd_utils;

enum gdEnum(string EnumName, InputEnum, string fqnInputEnum = InputEnum.stringof) = ()
{
    string expandEnum = "@Enum enum " ~ EnumName ~ " {";
    foreach(m; __traits(allMembers, InputEnum))
        expandEnum ~= m ~ " = " ~ fqnInputEnum ~ "." ~ m ~ ",";
    
    expandEnum  ~= "}";
    return expandEnum;
} ();