add_rules("mode.release", "mode.debug")

target("common")
   set_plat("windows")
   set_arch("x64")

   set_kind("static")
   set_pcxxheader("include/IPrefix.h")
   add_files("src/*.cpp")
   add_includedirs("include")
   add_headerfiles("include/*.h","include/*.inc")
   set_version("2.0.0")