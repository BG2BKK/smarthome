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

M.sub = function(self)
	r_sub = self.m:subscribe(sub_t, 0, m_on_sub)
end

M.pub = function(self, data)
	r_pub = self.m:publish(pub_t, data, 0, 0, m_on_sent)
end

M.connect = function(self)
	self.m:connect("192.168.2.163", 1883, 0, m_on_connect, m_on_connect_fail) 
end

M.new = function(self)
	m = mqtt.Client(clientid, 120, "user", "password", 0)
	m:lwt(lwt_t, "offline", 0, 0)
	m:on("offline", m_on_offline)
	m:on("message", m_dispatch)
	self.m = m

	return setmetatable(self, M)
end

return M
