package("skse64_common")
    set_homepage("https://github.com/mono-cyte/skse64_common")
    set_description("")

    add_urls("https://github.com/mono-cyte/skse64_common/archive/refs/tags/$(version).tar.gz",
    "https://github.com/mono-cyte/skse64_common.git")

    
    add_versions("0.0.1", "64cab227431f0840f97cd10c5341d6caeb5858ba4ff8cc33a8513b1cd1dfb354")

    on_install(function (package)
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
        
    end)
