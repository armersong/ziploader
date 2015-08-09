LUA_ZPATH='cgi.zip'
require 'ziploader'

local function main()
	local lp = require 'cgi/lp'

    for k,v in pairs( package.loaded ) do
        print("module ",k,v)
    end


    for k,v in pairs( lp ) do
        print("cgi/lp ",k,v)
    end
end

main()
