#ifndef CROSSEMU_IMPORT_H
#define CROSSEMU_IMPORT_H

    #ifdef __cplusplus
        #define CROSSEMU_EXTERN_C extern "C"
    #else
        #define CROSSEMU_EXTERN_C extern
    #endif

    #if defined(WIN32) || defined(_WIN32) || defined(__WIN32) && !defined(__CYGWIN__)
        // WINDOWS
        #if defined(CROSSEMU_BUILDING_SDK)
            #define CROSSEMU_SDK CROSSEMU_EXTERN_C __declspec(dllexport)
        #else
            #define CROSSEMU_SDK CROSSEMU_EXTERN_C __declspec(dllimport)
        #endif

        #ifdef _MSC_VER
            #pragma warning(disable : 4251)
        #endif
    #else
        // UNIX
        #define CROSSEMU_SDK CROSSEMU_EXTERN_C __attribute__((visibility("default")))
    #endif

#endif