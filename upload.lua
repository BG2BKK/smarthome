local moduleName = ...
local M = {}
_G[moduleName] = M

require("utils")
require("sock")
require("http")

local upload_task = function(code, data)
end

local heartbeat_task = function(code, data)
	if code == 200 then
		log(data)
		local resp = cjson.decode(data)
		if resp then
			user_input = resp.data or ''
		end
	end
end


local wrapper = function(f, data)
    local postData = cjson.encode(data)
--	sock.send(postData)
	local queryurl = 'http://'..server_ip..':'..server_port..query_url
	http.post(queryurl, nil, postData, function(code, data)
										f(code, data)
									   end)
end

M.heartbeat = function()

    local data = {
		['type']	= 'heartbeat',
    	['chipid']	= chipid or '',
    	['mac']		= mac or '',
    	['time']	= tmr.time() or '',
	}

	wrapper(heartbeat_task, data)

end


M.upload = function()

    local data = {
	    temp   = temp,
    	hum    = hum,
    	chipid = chipid or '',
    	mac    = mac or '',
	   	time   = tmr.time() or '',
	}

    wrapper(upload_task, data)
end



return M
