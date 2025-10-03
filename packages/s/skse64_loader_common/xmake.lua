package("skse64_loader_common")
    set_homepage("https://github.com/mono-cyte/skse64_loader_common")
    set_description("")

    add_repositories("monocyte-repo https://github.com/mono-cyte/monocyte-repo.git")
    add_requires("common", "skse64_version")

    add_syslinks("shlwapi", "version", "comdlg32", "user32", "shell32","advapi32")

    add_urls("https://github.com/mono-cyte/skse64_loader_common/archive/refs/tags/$(version).tar.gz",
             "https://github.com/mono-cyte/skse64_loader_common.git")

    add_versions("0.0.2", "207e2e861a9062d6586daa1aea315657d0cc01dd0c84beeaf84cae81d6a880aa")

    on_install("windows|x64", function (package)
        local configs = {}
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
    end)
