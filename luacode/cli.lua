local moduleName = ...
local M = {}
_G[moduleName] = M

require("upload")
m_on_connect = function(client)	
    print ("connected")
	m_is_connecting = true
end

m_on_connect_fail = function(client)    
    print("connect to server error")
	m_is_connecting = false
end

m_on_offline = function(client) 
    print ("offline") 
	m_is_connecting = false
	m_is_subscribing = false

	upload.mqtt_offline()

end

m_dispatch = function(client, topic, data)
  print(clientid, topic .. ":")
  if data ~= nil then
    print(data)
  end
end

m_on_sub = function(client)
	print("subscribe success") 
	m_is_subscribing = true
	upload.mqtt_online()
end

m_on_sent = function(client) 
	print("sent")
end

M.m_sub = function()
	if not checkip() then return end
	r_sub = m:subscribe(sub_t, 0, m_on_sub)
end

M.m_pub = function(data)
	if not checkip() then return end
	r_pub = m:publish(pub_t, data, 0, 0, m_on_sent)
end

M.m_connect = function()
	if not checkip() then return end
	m:connect(mqtt_ip, mqtt_port, 0, m_on_connect, m_on_connect_fail) 
end

M.m_init = function()
	m = mqtt.Client(clientid, 120, "user", "password", 0)
	m:lwt(lwt_t, "offline", 0, 0)
	m:on("offline", m_on_offline)
	m:on("message", m_dispatch)
end

M.m_exist = function()
	return m and true or false
end

return M
