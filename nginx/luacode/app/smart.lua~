local smart = {
  _VERSION     = 'smart.lua v0.0.1',
  _DESCRIPTION = 'smart home',
}

------------------------------ INSTANCE METHODS ------------------------------------
local Smart = {}

function Smart:recv()
	local request_body = ngx.var.request_body
	ngx.say(request_body)
	ngx.log(ngx.ERR, request_body)
end


local smart_mt = { __index = Smart }

------------------------------ PUBLIC INTERFACE ------------------------------------
smart.new = function()
  return setmetatable({ _tree = {} }, smart_mt)
end

return smart
