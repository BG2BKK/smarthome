
server_port = 8080
server_ip = "192.168.2.163"

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

