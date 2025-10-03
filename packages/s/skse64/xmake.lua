package("skse64")
    set_homepage("https://github.com/mono-cyte/skse64")
    set_description("")

    add_urls("https://github.com/mono-cyte/skse64/archive/refs/tags/$(version).tar.gz",
             "https://github.com/mono-cyte/skse64.git")

    add_versions("0.0.1", "c0c0f12c66b857eab0842d4c7940e10b1874474131c671248d12ab348e35a9bd")

    on_install(function (package)
        local configs = {}
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
    end)
