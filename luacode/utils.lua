

log = function(...)
	if uart_debug then
		print(...)
	end
end

checkip = function()
--    cli_ip = wifi.sta.getip()
	if not cli_ip then
        http_log = "Network Unavaliable"
		return log(http_log) 
	else
		return true
	end
end
