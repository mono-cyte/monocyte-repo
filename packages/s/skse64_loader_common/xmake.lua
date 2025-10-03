package("skse64_loader_common")
    set_homepage("https://github.com/mono-cyte/skse64_loader_common")
    set_description("")

    add_urls("https://github.com/mono-cyte/skse64_loader_common/archive/refs/tags/$(version).tar.gz",
             "https://github.com/mono-cyte/skse64_loader_common.git")

    add_versions("0.0.2", "207e2e861a9062d6586daa1aea315657d0cc01dd0c84beeaf84cae81d6a880aa")

    on_install(function (package)
        local configs = {}
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
    end)
