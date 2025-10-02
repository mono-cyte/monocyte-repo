package("skse64_loader_common")
    set_homepage("https://github.com/mono-cyte/skse64_loader_common")
    set_description("")

    add_urls("https://github.com/mono-cyte/skse64_loader_common/archive/refs/tags/$(version).tar.gz",
             "https://github.com/mono-cyte/skse64_loader_common.git")

    add_versions("0.0.1", "829fac35f79f741ac480bf11f9af0d055cb7a7e5255deacf97815ae0541ca10c")

    on_install(function (package)
        local configs = {}
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
    end)
