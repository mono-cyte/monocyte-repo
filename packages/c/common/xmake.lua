

package("common")
    set_homepage("https://github.com/mono-cyte/common")
    set_description("Common classes used by the script extenders")
    set_license("zlib")

    add_urls("https://github.com/mono-cyte/common/archive/refs/tags/$(version).tar.gz",
        "https://github.com/mono-cyte/common.git")
    add_versions("0.0.1", "c6cc97b3e739c8cedc071d0dd1219bf987af16e5a8851a79cbe1ae1de3dcfb33")

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
