local smart = {
	_VERSION     = 'smart.lua v0.0.1',
	_DESCRIPTION = 'smart home',
}

local cjson = require"cjson.safe"
local redis = require"resty.redis"

local proc = function(postdata)
	local data = cjson.decode(postdata)

	local resp = {}
	resp.msg = 'got ' 

	if data then

		resp.msg = 'got ' .. data.mac or 'unknow device'
		local dev_id = data.chipid
		local dev_mac = data.mac
		local key = table.concat({dev_mac, dev_id, 'info'}, ':')
		local led = table.concat({dev_mac, dev_id, 'led' }, ':')
		local red = redis:new()
		red:set_timeout(10000)

		local ok, err = red:connect("127.0.0.1", 6379)
		if not ok then
			ngx.log(ngx.ERR, "failed to connect: ", err)
			return {}
		end

		local ret, err = red:hget('smarthome', key)
		if not ret then
			ngx.log(ngx.ERR, "failed hget: ", err)
		end
		resp.data = ret

		red:set_keepalive(10000, 100)
	end
	return resp
end

------------------------------ INSTANCE METHODS ------------------------------------
local Smart = {}
function Smart:recv()
	local request_body = ngx.var.request_body
	ngx.log(ngx.ERR, request_body)

	local resp = proc(request_body)
	ngx.say(cjson.encode(resp))
end


local smart_mt = { __index = Smart }

------------------------------ PUBLIC INTERFACE ------------------------------------
smart.new = function()
	return setmetatable({ _tree = {} }, smart_mt)
end

return smart
