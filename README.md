#ziploader
Lua module that loads module from zip file
NOTE: only support lua script file!

#Usage
##set zip file list
```
LUA_ZPATH='test.zip;xxxx'
```

##install loader into system(package.loaders)
```
require 'ziploader'
```

##use module in zip file
```
require 'test.a'
```
