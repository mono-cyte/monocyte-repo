import("core.package.package")
import("core.base.semver")
import("core.base.hashset")
import("devel.git")
import("packages", { alias = "packages_util" })

function _load_package(packagename, packagedir, packagefile)
    local funcinfo = debug.getinfo(package.load_from_repository)
    if funcinfo and funcinfo.nparams == 3 then -- >= 2.7.8
        return package.load_from_repository(packagename, packagedir, { packagefile = packagefile })
    else
        -- deprecated
        return package.load_from_repository(packagename, nil, packagedir, packagefile)
    end
end

function _get_all_packages(pattern)
    local packages = _g.packages
    if not packages then
        packages = {}
        for _, packagedir in ipairs(os.dirs(path.join("packages", "*", "*"))) do
            local packagename = path.filename(packagedir)
            if not pattern or packagename:match(pattern) then
                local packagefile = path.join(packagedir, "xmake.lua")
                local instance = _load_package(packagename, packagedir, packagefile)
                local basename = instance:get("base")
                if instance and basename then
                    local basedir = path.join("packages", basename:sub(1, 1):lower(), basename:lower())
                    local basefile = path.join(basedir, "xmake.lua")
                    instance._BASE = _load_package(basename, basedir, basefile)
                end
                if instance then
                    table.insert(packages, instance)
                end
            end
        end
        _g.packages = packages
    end
    return packages
end

function _update_package_file(instance, version, shasum)
    local inserted = false
    local scriptfile = path.join(instance:scriptdir(), "xmake.lua")
    local version_current
    if os.isfile(scriptfile) then
        io.gsub(scriptfile, "add_versions%(\"(.-)\",%s+\"(.-)\"%)", function(v, h)
            if not version_current or semver.compare(v, version_current) > 0 then
                version_current = v
            end
            if not inserted then
                inserted = true
                return string.format('add_versions("%s", "%s")\n    add_versions("%s", "%s")', version, shasum, v, h)
            end
        end)
    end
    if not inserted then
        local versionfiles = instance:get("versionfiles")
        if versionfiles then
            for _, versionfile in ipairs(table.wrap(versionfiles)) do
                if not os.isfile(versionfile) then
                    versionfile = path.join(instance:scriptdir(), versionfile)
                end
                if os.isfile(versionfile) then
                    io.insert(versionfile, 1, string.format("%s %s", version, shasum))
                    inserted = true
                end
            end
        end
    end
    return inserted
end

function main(pattern)
    -- 检查参数
    assert(pattern, "pattern is required")

    local instances = _get_all_packages(pattern)


    for _, instance in ipairs(instances) do
        -- 指定 checkupdate 脚本
        local checkupdate_filepath = path.join(instance:scriptdir(), "checkupdate.lua")
        if not os.isfile(checkupdate_filepath) then
            checkupdate_filepath = path.join(os.scriptdir(), "checkupdate.lua")
        end

        if os.isfile(checkupdate_filepath) then
            local checkupdate = import("checkupdate",
                { rootdir = path.directory(checkupdate_filepath), anonymous = true })
            -- 获取 version, shasum
            local version, shasum = checkupdate(instance)

            if version and shasum then
                print("package(%s): new version %s found, shasum: %s", instance:name(), version, shasum)

                local success = _update_package_file(instance, version, shasum)
                if success then
                    print("  Updated package %s to version %s", instance:name(), version)
                else
                    print("  Failed to update package %s", instance:name())
                end
            end
        end
    end
end
