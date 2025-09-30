import("core.base.option")

function main()
    print("update monocyte-repo ..")
    os.exec("git clone git@github.com:mono-cyte/monocyte-repo.git -b dev --recurse-submodules")
    os.cd("xmake-repo")
    os.exec("git push git@github.com:mono-cyte/monocyte-repo.git dev")
    os.exec("git push git@github.com:mono-cyte/monocyte-repo.git dev")
    os.exec("git push git@github.com:mono-cyte/monocyte-repo.git dev")
    os.exec("git checkout master")
    os.exec("git merge dev")
    os.exec("git push git@github.com:mono-cyte/monocyte-repo.git master")
end
