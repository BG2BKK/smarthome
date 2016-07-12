local moduleName = ...
local M = {}
_G[moduleName] = M

M.upload = function()
    if not ip then
        http_log = "no network avaliable"
		print(http_log)
        return
    end

    local data = {}
    data.temp   = temp
    data.hum    = hum
    data.chipid = chipid or ''
    data.mac    = mac or ''
    data.time   = tmr.time() or ''

    local PostData = cjson.encode(data)

	http_log = "Send to " .. server_ip .. ':' .. server_port
	print(http_log)

    conn=net.createConnection(net.TCP, 0) 
    conn:connect(server_port, server_ip) 

    conn:on("sent",function(conn)
		http_log = 'Closing connection'
		print(http_log)
    end)

    conn:on("disconnection", function(conn)
		http_log = "Got disconnection..."
		print(http_log)
    end)

    conn:on("receive", function(conn, payload) 
		http_log = payload
        print(payload) 
    end)

    conn:send(
		'POST ' .. query_url .. " HTTP/1.0\r\n" ..
		"Host: localhost\r\n" ..
		"Accept: */*\r\n" ..
		"Content-Length: ".. string.len(PostData) .. 
		"\r\n\r\n" ..
		PostData .. "\r\n\r\n"
    )
end


return M
