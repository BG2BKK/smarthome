-- init mqtt client with keepalive timer 120sec
m = mqtt.Client("clientid", 120, "user", "password", 1)

-- setup Last Will and Testament (optional)
-- Broker will publish a message with qos = 0, retain = 0, data = "offline" 
-- to topic "/lwt" if client don't send keepalive packet
m:lwt("/lwt", "offline", 0, 0)

m:on("connect", function(client) print ("connected") end)
m:on("offline", function(client) print ("offline") end)

-- on publish message receive event
m:on("message", function(client, topic, data) 
  print(topic .. ":" ) 
  if data ~= nil then
    print(data)
  end
end)

-- for TLS: m:connect("192.168.11.118", secure-port, 1)
m:connect("192.168.2.163", 1883, 0, function(client) print("connected") end, 
                                     function(client, reason) print("failed reason: "..reason) end)

-- Calling subscribe/publish only makes sense once the connection
-- was successfully established. In a real-world application you want
-- move those into the 'connect' callback or make otherwise sure the 
-- connection was established.

tmr.delay(10000)
-- subscribe topic with qos = 0
m:subscribe("/bg2bkk",0, function(client) print("subscribe success") end)


-- publish a message with data = hello, QoS = 0, retain = 0
m:publish("/bg2bkk","hello",0,0, function(client) print("sent") end)

m:close();
-- you can call m:connect again
