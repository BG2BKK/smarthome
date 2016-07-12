local connectRouter = function()
    print("set up wifi mode")
    wifi.setmode(wifi.STATION)
    wifi.sta.config("huang","sh19901222")
end

tmr.alarm(1, 1000, 1, function() 
    if wifi.sta.getip()== nil then 
    	print("IP unavaiable, Waiting...") 
    else 
    	tmr.stop(1)
    	print("Config done, IP is "..wifi.sta.getip())
    end 
end)


local sendRequest = function()
    conn=net.createConnection(net.TCP, false)

    conn:on("receive", function(conn, pl) print(pl) end)

    conn:connect(80,"45.78.38.250")

    conn:send("GET / HTTP/1.1\r\nHost: localhost\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n")
end

local readFile = function(filename)
    file.open(filename, "r")
    local t = file.readline()
    print(t)
end
    

file.open("user.lua","w")
file.writeline([[local connectRouter = function()    print("set up wifi mode")    wifi.setmode(wifi.STATION)    wifi.sta.config("huang_WIFI","jiayoubrandon")end]])
file.writeline([[connectRouter()]])
 file.writeline([[tmr.alarm(1, 1000, 1, function()     if wifi.sta.getip()== nil then          print("IP unavaiable, Waiting...")     else        tmr.stop(1)     print("Config done, IP is "..wifi.sta.getip())    end end)]])
 file.close()

 print(wifi.sta.getip())


local led = function(i, duration)
    gpio.mode(i, gpio.OUTPUT)
    gpio.write(i, gpio.LOW)  
    tmr.delay(100000)
    gpio.write(i, gpio.HIGH);
    tmr.delay(100000)
end

local ledBlink = function(i, duration)
    tmr.alarm(0, duration, 1, function() v = 0 function() v = not v gpio.write(i, v) end end)
end

fl = file.list()
for k, v in pairs(fl)
do
	print(k, v)
end

tmr.stop(0)



data = {}    data.temp   = temp    data.hum    = hum    data.chipid = chipid or ''    data.mac    = mac or ''    data.time   = tmr.time() or ''
PostData = cjson.encode(data)
str =  'POST ' .. '/dht11' .. " HTTP/1.1\r\n" .. "Host: localhost\r\n" .. "Content-Length: ".. string.len(PostData) .. "\r\n" .. "Accept: */*\r\n" .. PostData .."\r\n"
conn=net.createConnection(net.TCP, 0)  conn:connect(80, '101.200.124.174')  conn:send(str)

POST /dht11 HTTP/1.1
Host: localhost
Accept: */*
{"mac":"","time":1781,"chipid":"", "temp":"20", "hum":"35"}


node.restart()  
tmr.stop(1) 
tmr.stop(6) 
