local moduleName = ...
local M = {}
_G[moduleName] = M

require("utils")
require("http")

local upload_task = function(code, data)
end

M.upload = function()
end

local heartbeat_task = function(code, data)
	if code == 200 then
		log(data)
		local resp = cjson.decode(data)
		if resp then
			user_input = resp.data or ''
		end
	else
		log('heartbeat error', data)
	end
end

M.heartbeat = function()

	if not checkip() then return end

	local hbeat_data = {
		msgtype	= 'heartbeat',
		chipid	= chipid or '',
		mac		= mac or '',
		time	= tmr.time() or '',
		heap	= node.heap() or '',
		temp	= temp,
		hum		= hum
	}

	local msg = cjson.encode(hbeat_data)

--	local msg = 'msgtype=' .. 'heartbeat' ..
--				'&chipid=' .. chipid or '' ..
--				'&mac=' .. mac or ''..
--				'&time=' .. tmr.time() or ''..
--				'&heap=' .. node.heap() or ''

	http.post(query_url, nil, msg, heartbeat_task)

end

local mqtt_offline_task = function(code, data)
	log('mqtt_offline_task', data)
end
M.mqtt_offline = function()
	if not checkip() then return end

	local offline_data = {
		msgtype	= 'mqtt_offline',
		chipid	= chipid or '',
		mac		= mac or '',
		time	= tmr.time() or ''
	}

	local msg = cjson.encode(offline_data)

	http.post(query_url, nil, msg, mqtt_offline_task)
end

local mqtt_online_task = function(code, data)
	log('mqtt_online_task', data)
end

M.mqtt_online = function()
	if not checkip() then return end

	local online_data = {
		msgtype	= 'mqtt_online',
		chipid	= chipid or '',
		mac		= mac or '',
		time	= tmr.time() or ''
	}

	local msg = cjson.encode(online_data)

	http.post(query_url, nil, msg, mqtt_online_task)
end

M.mqtt_msg = function(clientid, topic, data)
	if not checkip() then return end

	local mqtt_data = {
		msgtype	= 'mqtt_msg',
		chipid	= chipid ,
		mac		= mac ,
		time	= tmr.time() ,
		id		= clientid ,
		topic	= topic ,
		msg		= data ,
	}

	local msg = cjson.encode(mqtt_data)

	http.post(query_url, nil, msg)
end


return M
