local moduleName = ...
local M = {}
_G[moduleName] = M

m_on_connect = function(client)	
    print ("connected")
	local m = M.m
	r_sub = m:subscribe(sub_t,0, function(client) print("subscribe success") end)
	r_pub = m:publish(pub_t,"hello",0,0, function(client) print("sent") end)
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


local _mt = { __index = M }

M.new = function(self)
	local m = mqtt.Client(clientid, 120, "user", "password", 0)
	m:lwt(lwt_t, "offline", 0, 0)
	m:on("offline", m_on_offline)
	m:on("message", m_dispatch)

	self.m = m
	return setmetatable(self, mt)
end

M.connect = function(self)
	local m = self.m
	m:connect("192.168.2.163", 1883, 0, m_on_connect, m_on_connect_fail) 
end


return M
