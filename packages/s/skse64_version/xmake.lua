package("skse64_version")
    set_homepage("https://github.com/mono-cyte/skse64_version")
    set_description("Version Package for SKSE64 building")

    add_urls("https://github.com/mono-cyte/skse64_version/archive/refs/tags/$(version).tar.gz",
    "https://github.com/mono-cyte/skse64_version.git")

    add_versions("0.0.1", "bc9fba9f2e9510dad79721fab4e662eb21edc5c550992df58c29f6caa41b6b3d")

    set_kind("library", {headeronly = true})

    add_configs("skse_version", {description = "Version of SKSE", default = "2.2.6"})
    add_configs("skyrim_version", {description = "Version of Skyrim", default = "1.6.1170"})
    add_configs("runtime", {description = "Runtime of Skyrim", default = "bethesda", values = {"bethesda", "gog", "epic"}})

    on_install("windows|x64", function (package)
        local configs = {}

        configs.skse_version = package:config("skse_version")
        configs.skyrim_version = package:config("skyrim_version")
        configs.runtime = package:config("runtime")

        import("package.tools.xmake").install(package, configs)

        cprint("${onblue} skse_version: " .. configs.skse_version)
        cprint("${onblue} skyrim_version: " .. configs.skyrim_version)
        cprint("${onblue} runtime: " .. configs.runtime)
    end)

    on_load(function (package)
        package:add("files", "res/*.rc")
        package:add("rules", "attach_version")

        local types = {
            bethesda = 0,
            gog = 1,
            epic = 2
        }

        local rt = nil
        local runtime = package:config("runtime")
        if runtime == "bethesda" then
            rt = types.bethesda
        elseif runtime == "gog" then
            rt = types.gog
        elseif runtime == "epic" then
            rt = types.epic
        end

        local rv = {}
        rv.major, rv.minor, rv.patch = string.match(package:config("skyrim_version"), "(%d+)%.(%d+)%.(%d+)")
        rv.major = tonumber(rv.major)
        rv.minor = tonumber(rv.minor)
        rv.patch = tonumber(rv.patch)
        rv.packed =
            (rv.major & 0xFF) << 24 |
            (rv.minor & 0xFF) << 16 |
            (rv.patch & 0xFFF) << 4 |
            (rt & 0xF)

        assert(rt, "Invalid runtime specified")
        -- necessary config for RUNTIME
        package:add("defines", "RUNTIME")
        package:add("defines", "RUNTIME_VERSION=" .. rv.packed)
        package:add("files", package:installdir("res/*.rc"))
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            #include <skse_version.h>
            #ifdef RUNTIME_VERSION
            #else
            #error "Failed to link"
            #endif
        ]]}, {configs = {languages = "c++11"}}))
        
    end)
