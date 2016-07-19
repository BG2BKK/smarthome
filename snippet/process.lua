local response = "HTTP/1.0 200 OK\r\nServer: NodeMCU on ESP8266\r\nContent-Type: text/html\r\n200"

local data
process = function(payload)
	local i = 0
	local lastline 
	while true do
		i = string.find(payload, '\r\n', i+1)
		print(i)
		if not i then
			break
		else
			data = string.sub(payload, i)
		end

	end

end


process(response)

print('data: ', data)
-- conn:send(
-- 	"GET /test/huang HTTP/1.1\r\n" ..
-- 	"Host: localhost\r\n" ..
-- 	"Connection: keep-alive\r\n" ..
-- 	"Accept: */*\r\n" ..
-- 	"\r\n"
-- )
