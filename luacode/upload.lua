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
	else
		log('heartbeat error', data)
	end
end

M.heartbeat = function()

	hbeat_data.time = tmr.time() or ''

	local msg = cjson.encode(hbeat_data)

	http.post(query_url, nil, msg, heartbeat_task)

end


M.upload = function()
end



return M
