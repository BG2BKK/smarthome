local moduleName = ...
local M = {}
_G[moduleName] = M

M.display = function(switch)
	if switch == true then
		tmr.alarm(oled_tid, oled_int, 1, function() 
			display[d_ip][3] = cli_ip or 'unavaliable'
			display[d_temp][3] = temp or ''
			display[d_hum][3] = hum or ''
			display[d_upload][3] = http_log or ''
			display[d_input][3] = user_input or ''
			display[d_heap][3] = node.heap() or ''
			oled.drawStrs(display)		
		end)
	elseif switch == false then
		trm.stop(oled_tid)
	end
end

M.startTran = function()
	tmr.alarm(conn_tid, conn_int, 1, function() 
		log('send heartbeat', node.heap())
		upload.heartbeat()
	end)
end

M.getData = function()
	tmr.alarm(dht11_tid, dht11_int, 1, function()
		log('fetch sensor', node.heap())
		dht11.read(dht11_pin)
	end)
end

M.mqtt_sub = function()
	cli.m_init()

	tmr.alarm(mqtt_tid, mqtt_int, 1, function() 
		if not checkip() then 
			return 
		end
		if not cli.m_exist() then 
			return cli_m_init()
		end
		if not m_is_connecting then
			return cli.m_connect()
		end
		if not m_is_subscribing then
			return cli.m_sub()
		end

	local mqtt_hb = {
		msgtype	= 'mqtt_msg',
		chipid	= chipid ,
		mac		= mac ,
		time	= tmr.time() ,
		msg		= 'mqtt hello',
		temp	= temp,
		hum		= hum
	}

	local msg = cjson.encode(mqtt_hb)
		cli.m_pub(msg)
	end)

end

M.run = function()
	M.display(true)
	M.getData()
	M.startTran()
	M.mqtt_sub()
end

M.init = function()
	log('init.lua ver 1.2')
	log('MAC: ', mac)
	log('chip: ', chipid)
	log('flashid: ', flashid)

	remote.initwifi(ssid, pwd)
	remote.conn_callback()
	oled.init_oled(sda, scl, sla)
	oled.boot_page()
end

return M
