

package("common")
    set_homepage("https://github.com/mono-cyte/common")
    set_description("Common classes used by the script extenders")
    set_license("zlib")

    add_urls("https://github.com/mono-cyte/common/archive/refs/tags/$(version).tar.gz",
        "https://github.com/mono-cyte/common.git")



    add_versions("0.0.3", "45298759ee73357d425cede7089cfd4215a0a9b1b17c1e20cca2f468bab1a905")
    add_versions("0.0.2", "015a3563481ccf77270b31342fb1f031d396e8917e7081bf536f68e620c799a2")


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
