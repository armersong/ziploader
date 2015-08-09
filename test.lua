LUA_ZPATH='test.zip'
require 'ziploader'

local function main()
	local m = require 'test.a'

    print('_G:')
    for k,v in pairs( _G ) do
        print(k,v)
    end
    
    print('package.loaded:')
    for k,v in pairs( package.loaded ) do
        print(k,v)
    end


    print('test.a:')
    for k,v in pairs( m ) do
        print("test.a ",k,v)
    end
end

main()
