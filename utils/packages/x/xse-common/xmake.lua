package("xse-common")
    set_description("Common classes library used by the script extenders for Bethesda's games")

        add_urls("https://github.com/mono-cyte/common")

        on_install("windows|x64",function (package)
            local configs = {}
            if package:config("shared") then
                configs.kind = "shared"
            end
            import("package.tools.xmake").install(package, configs)
        end)

        on_test("windows|x64",function (package)
            assert(package:check_cxxsnippets({test = [[
                #include "common/ICriticalSection.h"
                static ICriticalSection	s_raceCacheLock;
            ]]
            }, {configs = {languages = "c++11"} }))
        end)
