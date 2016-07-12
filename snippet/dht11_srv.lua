require("dht11")
  --创建一个定时器
  tmr.alarm(0, 60000, 1, function()
  	--初始化并设置引脚3
  	dht11.init(3)
  	--读取DHT11的温度数据
  	Temp = dht11.getTemp()
  	--读取DHT11的湿度数据
  	Hum = dht11.getHumidity()
    print("Temp "..Temp)
    print("Hum "..Hum)
--  	--定义数据变量格式
--  	PostData = "[{\"Name\":\"T\",\"Value\":\"" .. Temp .. "\"},{\"Name\":\"H\",\"Value\":\"" .. Hum .. "\"}]"
--  	--创建一个TCP连接
--  	socket=net.createConnection(net.TCP, 0)
--  	--域名解析IP地址并赋值
----  	socket:dns("www.lewei50.com", function(conn, ip)
----  		ServerIP = ip
----  		print("Connection IP:" .. ServerIP)
----  		end)
--  	--开始连接服务器
--    ServerIP="101.200.124.174"
--  	socket:connect(80, ServerIP)
--  	socket:on("connection", function(sck) end)
--  	--HTTP请求头定义
--  	socket:send("POST /api/V1/gateway/UpdateSensors/02 HTTP/1.1\r\n" ..
--  				"Host: localhost\r\n" ..
--  				"Content-Length: " .. string.len(PostData) .. "\r\n" ..
--  				PostData .. "\r\n")
--  	--HTTP响应内容
--  	socket:on("receive", function(sck, response)
--  		print(response)
--  		end)	
end)
