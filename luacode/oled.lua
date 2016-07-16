local moduleName = ...
local M = {}
_G[moduleName] = M

M.init_oled = function(sda,scl,sla)

    i2c.setup(0, sda, scl, i2c.SLOW)
    disp = u8g.ssd1306_128x64_i2c(sla)

    disp:setFont(u8g.font_6x10)
    disp:setFontRefHeightExtendedText()
    disp:setDefaultForegroundColor()
    disp:setFontPosTop()

end

M.boot_page = function()
    disp:firstPage()

    repeat 
        disp:drawStr(0, 24, "Hello NodeMcu")
    until disp:nextPage() == false
end

M.drawStr = function(x, y, str)
    disp:firstPage()
    repeat 
        disp:drawStr(x, y, str)
    until disp:nextPage() == false
end

M.drawStrs = function(strs)
    disp:firstPage()
    repeat 
		for _, dat in pairs(strs) do
            disp:drawStr(dat.x, dat.y, dat.data)
		end
    until disp:nextPage() == false
end

return M
