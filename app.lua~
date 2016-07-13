local moduleName = ...
local M = {}
_G[moduleName] = M

M.display = function()
	tmr.alarm(oled_tmrid, oled_interval, 1, function() 
		display[d_ip].data = ip or 'unavaliable'
		display[d_temp].data = temp or ''
		display[d_hum].data = hum or ''
		display[d_upload].data = http_log or ''
		oled.drawStrs(display)		
	end)
end

M.startTran = function()
    tmr.alarm(conn_tmrid, conn_interval, 1, function() 
        upload.upload()
    end)
end

M.getData = function()
    tmr.alarm(dht11_tmrid, dht11_interval, 1, function()
        dht11.init(dht11_pin)
        temp = dht11.getTemp()
        hum = dht11.getHumidity()
    end)
end

M.run = function()
	app.display()
	app.getData()
	app.startTran()
end

M.init = function()
	sock.init(ssid, pwd)
	oled.init_oled(sda, scl, sla)
	oled.boot_page()
	sock.conn_callback()
end

return M
