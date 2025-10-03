package("skse64")
    set_homepage("https://github.com/mono-cyte/skse64")
    set_description("")

    add_repositories("monocyte-repo https://github.com/mono-cyte/monocyte-repo.git")
    add_requires("common","skse64_version","skse64_common","xbyak")

    add_syslinks("user32", "comdlg32", "shell32")

    add_urls("https://github.com/mono-cyte/skse64/archive/refs/tags/$(version).tar.gz",
             "https://github.com/mono-cyte/skse64.git")

    add_versions("0.0.1", "c0c0f12c66b857eab0842d4c7940e10b1874474131c671248d12ab348e35a9bd")

    on_install("windows|x64", function (package)
        local configs = {}
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
    end)
