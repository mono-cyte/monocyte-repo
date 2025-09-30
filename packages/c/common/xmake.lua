

package("common")
    set_homepage("https://github.com/mono-cyte/common")
    set_description("Common classes used by the script extenders")
    set_license("zlib")

    add_urls("https://github.com/mono-cyte/common/archive/refs/tags/$(version).tar.gz",
        "https://github.com/mono-cyte/common.git")


    add_versions("0.0.1", "46a5ad14e7d2b1b65f4bdc8e7c9b079f7728b2eb5932b71433c6ac76a630f517")


    on_install("windows|x64", function (package)
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
