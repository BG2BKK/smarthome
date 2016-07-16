local moduleName = ...

local M = {}

_G[moduleName] = M

function M.read(pin)
	status, temp, hum, temp_dec, humi_dec = dht.read(pin)
	if status == dht.OK then
		log("DHT Temperature:"..temp..";".."Humidity:"..hum)
	elseif status == dht.ERROR_CHECKSUM then
		log( "DHT Checksum error." )
	elseif status == dht.ERROR_TIMEOUT then
		log( "DHT timed out." )
	end
end

return M

