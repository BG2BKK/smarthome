local router = require 'router.router'
local smartmod = require 'smart'
local adminmod = require 'admin'
local smart = smartmod.new()
local admin = adminmod.new()
local r = router.new()

r:match({
	GET = {
		["/hello/:name"] = function(params) ngx.print("hello, " .. params.name) end,
		["/admin/set/:info"] = function(params) admin.set(params.info) end
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

if not ok then
	ngx.status = 404
	ngx.print("Not found!")
	ngx.log(ngx.ERR, errmsg)
end
