local conn=net.createConnection(net.TCP, 0)  
tmr.alarm( 1, 3000, 1, function()
    local data = {}
    data.temp   = temp or 24 
    data.hum    = hum or 23 
    data.chipid = chipid or '' 
    data.mac    = mac or '' 
    data.time   = tmr.time() or '' 
    server_ip = '101.200.124.174' 
    server_port = 80 
    query_url = '/dht11' 

    local PostData = cjson.encode(data) 
    print(PostData) 

    print("Sending data to " .. server_ip .. ':' .. server_port) 
    conn:connect(server_port, server_ip)  

    conn:on("sent",function(conn)
        print("Closing connection")
        --    conn:close()
    end)

    conn:on("disconnection", function(conn)
        print("Got disconnection...")
    end)

    conn:on("receive", function(conn, payload) 
        print(payload) 
    end)

    conn:send('POST ' .. query_url .. " HTTP/1.1\r\n" ..
    "Host: localhost\r\n" ..
    "Accept: */*\r\n" ..
    "Content-Length: ".. string.len(PostData) .. "\r\n\r\n" ..

    PostData .. "\r\n"
    )
end)
