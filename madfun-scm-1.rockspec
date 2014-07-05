package = "MADfun"
version = "scm-1"

source = {
   url = "git://github.com/LAEH/MADfun",
   branch = "master"
}

description = {
   summary = "MADfun",
   detailed = [[
      fun Text Developement Context
   ]],
   homepage = "https://github.com/LAEH/MADfun",
   license = "BSD"
}

dependencies = {
}

build = {
   type = "builtin",
   modules = {
      ['MADfun.init'] = 'init.lua',
   }
}
