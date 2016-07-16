local moduleName = ...
local M = {}
_G[moduleName] = M

M.initconn = function()
end

M.send = function(data)

    if not ip then
        http_log = "Network Unavaliable"
		return log(http_log) -- nil
    end

    conn=net.createConnection(net.TCP, 0) 
    conn:connect(server_port, server_ip) 

    conn:on("sent",function(conn)
		http_log = 'Closing connection'
		log(http_log)
    end)

    conn:on("disconnection", function(conn)
		http_log = "Got disconnection..."
		log(http_log)
    end)

    conn:on("receive", function(conn, payload) 
		http_log = payload
		log(payload)
--		local i, j = string.find(payload, '\n')
--		local dat = string.sub(payload, j+1)
--			log(dat)
--		if dat then
--			user_input = dat or ''
--		end
    end)


    conn:send(
		'POST ' .. query_url .. " HTTP/1.0\r\n" ..
		"Host: localhost\r\n" ..
		"Accept: */*\r\n" ..
		"Content-Length: ".. string.len(data) .. 
		"\r\n\r\n" ..
		data .. "\r\n\r\n"
    )

end

return M
