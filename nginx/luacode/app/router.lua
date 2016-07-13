local router = require 'router.router'
local smartmod = require 'smart'
local smart = smartmod.new()
local r = router.new()

r:match({
	GET = {
		["/hello/:name"] = function(params) ngx.print("hello, " .. params.name) end
	},
	POST = {
		["/smart"] = function(params)
			smart:recv()
		end
	}
})

local ok, errmsg = r:execute (
	ngx.var.request_method,
	ngx.var.request_uri,
	ngx.req.get_uri_args(),		-- all these parameters
	ngx.req.get_post_args(),	-- will be merged in order
	{other_arg = 1}				-- into a single "params" table
)

if ok then
	ngx.status = 200
else
	ngx.status = 404
	ngx.print("Not found!")
	ngx.log(ngx.ERR, errmsg)
end
