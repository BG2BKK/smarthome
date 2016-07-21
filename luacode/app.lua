local moduleName = ...
local M = {}
_G[moduleName] = M

require"remote"
M.display = function(switch)
	if switch == true then
		tmr.alarm(oled_tmrid, oled_interval, 1, function() 
			display[d_ip].data = cli_ip or 'unavaliable'
			display[d_temp].data = temp or ''
			display[d_hum].data = hum or ''
			display[d_upload].data = http_log or ''
			display[d_input].data = user_input or ''
			display[d_heap].data = node.heap() or ''
			oled.drawStrs(display)		
		end)
	elseif switch == false then
		trm.stop(oled_tmrid)
	end
end

M.startTran = function()
	tmr.alarm(conn_tmrid, conn_interval, 1, function() 
		log('send heartbeat', node.heap())
		upload.heartbeat()
	end)
end

M.getData = function()
	tmr.alarm(dht11_tmrid, dht11_interval, 1, function()
		log('fetch sensor', node.heap())
		dht11.read(dht11_pin)
	end)
end

M.mqtt_sub = function()
	cli.m_init()

	tmr.alarm(mqtt_tmrid, mqtt_interval, 1, function() 
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
