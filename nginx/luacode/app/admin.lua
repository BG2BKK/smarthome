local smart = {
	_VERSION     = 'smart.lua v0.0.1',
	_DESCRIPTION = 'smart home admin',
}

local cjson = require"cjson.safe"
local redis = require"resty.redis"

local proc = function(info)

	local resp = {
		code = 0,
		data = ''
	}
	local dev_id = 53914
	local dev_mac = "5c:cf:7f:00:d2:9a"
	local key = table.concat({dev_mac, dev_id, 'info'}, ':')
	local led = table.concat({dev_mac, dev_id, 'led' }, ':')
	local red = redis:new()
	red:set_timeout(10000)

	local ok, err = red:connect("127.0.0.1", 6379)
	if not ok then
		ngx.log(ngx.ERR, "failed to connect: ", err)
		resp.code = 500
		resp.data = err
		ngx.say(cjson.encode(resp))
		return resp
	end

	local ret, err = red:hset('smarthome', key, info)
	if not ret then
		ngx.log(ngx.ERR, "failed hget: ", err)
		resp.code = 500
		resp.data = err
		ngx.say(cjson.encode(resp))
		return resp
	end
	resp.code = 200
	resp.data = 'success'
	ngx.say(cjson.encode(resp))

	red:set_keepalive(10000, 100)
end

------------------------------ INSTANCE METHODS ------------------------------------
local Smart = {}
function Smart.set(info)
	ngx.log(ngx.ERR, info)
	proc(info)
end


local smart_mt = { __index = Smart }

------------------------------ PUBLIC INTERFACE ------------------------------------
smart.new = function()
	return setmetatable({ _tree = {} }, smart_mt)
end

return smart
