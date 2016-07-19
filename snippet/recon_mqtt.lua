mac = wifi.sta.getmac()
chipid = node.chipid()
id = mac..":"..chipid

n_pub = "/smart/"..id
n_sub = "/smart/"..id..'/#'

m_on_connect = function(client)	
    print ("connected")
	r_sub = m:subscribe(n_sub,0, function(client) print("subscribe success") end)
	r_pub = m:publish(n_pub,"hello",0,0, function(client) print("sent") end)
    print(r_sub, '\t', r_pub)
    print ("pub and sub done")    
end

m_on_connect_fail = function(client)    
    print("connect to server error")
end

m_on_offline = function(client) 
    print ("offline") 
end

m_dispatch = function(client, topic, data)
  print(id, topic .. ":")
  if data ~= nil then
    print(data)
  end
end

m = mqtt.Client(id, 120, "user", "password", 0)
m:lwt("/lwt", "offline", 0, 0)
m:on("offline", m_on_offline)
m:on("message", m_dispatch)
m:connect("192.168.2.163", 1883, 0, m_on_connect, m_on_connect_fail) 
