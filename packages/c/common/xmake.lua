

package("common")
    set_homepage("https://github.com/mono-cyte/common")
    set_description("Common classes used by the script extenders")
    set_license("zlib")

    add_urls("https://github.com/mono-cyte/common.git")
    add_versions("2025.09.29", "b2e0538f1c8a534d18e34686b6e3d82b477ed804")

    on_install(function (package)
        local configs = {}
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            #include <IPrefix.h>
            #include <ICriticalSection.h>
            static ICriticalSection	s_raceCacheLock;
        ]]
        }, {configs = {languages = "c++11"}} ))
    end)
