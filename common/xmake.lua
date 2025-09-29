package("common")
    set_homepage("https://github.com/mono-cyte/common")
    set_description("Common classes used by the script extenders")
    set_license("zlib")

    add_urls("https://github.com/mono-cyte/common.git")
    add_versions("2025.09.29", "7c61ee00aebe2e40ddcf32df5c660aa8d514888e")

    on_install(function (package)
        os.cp(path.join(package:scriptdir(), "port", "xmake.lua"), "xmake.lua")
        import("package.tools.xmake").install(package)
    end)

    on_test("windows|x64",function (package)
        assert(package:check_cxxsnippets({test = [[
            #include "ICriticalSection.h"
            static ICriticalSection	s_raceCacheLock;
        ]]
        }, {configs = {languages = "cxx11"}}))
    end)