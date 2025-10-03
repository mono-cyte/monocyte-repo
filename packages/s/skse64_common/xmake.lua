package("skse64_common")
    set_homepage("https://github.com/mono-cyte/skse64_common")
    set_description("")

    add_repositories("monocyte-repo https://github.com/mono-cyte/monocyte-repo.git")
    add_requires("common", "skse64_version")

    add_urls("https://github.com/mono-cyte/skse64_common/archive/refs/tags/$(version).tar.gz",
    "https://github.com/mono-cyte/skse64_common.git")


    add_versions("0.0.1", "64cab227431f0840f97cd10c5341d6caeb5858ba4ff8cc33a8513b1cd1dfb354")

    on_install("windows|x64", function (package)
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
        
    end)
