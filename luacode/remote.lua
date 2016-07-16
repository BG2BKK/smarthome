local moduleName = ...
local M = {}
_G[moduleName] = M

local cnt = 0

require("utils")
M.initwifi = function(ssid, pwd)    
    log("set up wifi mode")    
    wifi.setmode(wifi.STATION)    
    log('set mode=STATION (mode='..wifi.getmode()..')')
    wifi.sta.config(ssid, pwd)
end

M.conn_callback = function()

    tmr.alarm(wifi_tmrid, wifi_interval, 1, function()
        ip = wifi.sta.getip()
        if not ip then
            log("IP unavaiable, Waiting...")
            cnt = cnt + 1
            if cnt > 5 then
                tmr.stop(1)
                log("connect to WIFI error")
            end
        else
            tmr.stop(0)
            log("Config done, IP is "..ip)
        end
    end)

end

return M
