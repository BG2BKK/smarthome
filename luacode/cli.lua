local moduleName = ...
local M = {}
_G[moduleName] = M

m_on_connect = function(client)	
    print ("connected")
	r_sub = client:subscribe(sub_t,0, function(client) print("subscribe success") end)
	p_pub = client:publish(pub_t,"hello",0,0, function(client) print("sent") end)
    print(r_sub, '\t', p_pub)
    print ("pub and sub done")    
end

m_on_connect_fail = function(client)    
    print("connect to server error")
end

m_on_offline = function(client) 
    print ("offline") 
end

m_dispatch = function(client, topic, data)
  print(clientid, topic .. ":")
  if data ~= nil then
    print(data)
  end
end

m_on_sub = function(client)
	print("subscribe success") 
end

m_on_sent = function(client) 
	print("sent")
end

M.m_sub = function()
	r_sub = m:subscribe(sub_t, 0, m_on_sub)
end

M.m_pub = function(data)
	r_pub = m:publish(pub_t, data, 0, 0, m_on_sent)
end

M.m_connect = function()
	m:connect("192.168.2.163", 1883, 0, m_on_connect, m_on_connect_fail) 
end

M.m_init = function()
	m = mqtt.Client(clientid, 120, "user", "password", 0)
	m:lwt(lwt_t, "offline", 0, 0)
	m:on("offline", m_on_offline)
	m:on("message", m_dispatch)
end

return M
