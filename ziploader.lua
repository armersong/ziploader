--[[
    load lua script in zip file. Maybe used in embed system
    LUA_ZPATH : zip file list. seperate with ;
        i.e LUA_ZPATH='/tmp/cgi.zip;aaa.zip'
        NOTE: directory, * or ? not supported

    Usage:
    LUA_ZPATH="cgi.zip;bbb.zip"
    require 'ziploader'

    require 'module name in zip file'
--]]

require "zip"

local LUA_ZPATH = LUA_ZPATH or ""

local function parseZPath( path )
	local pathes = {}
	local pos = 1
	while( true ) do
		local s,e = string.find( path, ';', pos)
		if( s == nil ) then
			if( #path >0 and pos == 1 ) then
				pathes[ #pathes + 1 ] = path
			end 
			break 
		end
		pathes[ #pathes + 1 ] = string.sub( path, pos, s-1 )
		pos = e+1
	end
	return pathes
end

local function zipLoader( module )
    local name = string.gsub( module, '/', '.')
    local code = nil
	for _,v in pairs(parseZPath( LUA_ZPATH )) do
		local zip = zip.open( v )
		if( zip ~= nil ) then
			for f in zip:files() do
				if( f.compressed_size > 0 ) then
					local fn = string.gsub( f.filename, '/', '.');
					if( ( fn == name) or ( fn == name ..".lua")  ) then
						local zf = zip:open( f.filename)
                        local cnt = zf:read("*all")
						code = loadstring( cnt )
						zf:close()
                        break
					end
				end
			end
            zip:close()
		end
	end	
    if( code ~= nil ) then
    	package.loaded[module] = code
    end
    return code
end

package.loaders[#package.loaders+1] = zipLoader
package.zpath = LUA_ZPATH

return zipLoader

