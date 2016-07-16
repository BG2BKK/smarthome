
t = 'abc\r\nefg\r\n'
local i = 0
-- while true do
-- 	i = string.find(t, '\r\n', i+1)
-- 	if i then
-- 		print(string.sub(t, i+2))
-- 	else
-- 		break
-- 	end
-- end

i, j = string.find(t, '\r\n')
i, j = string.find(t, '\r\n',i+1)
s = string.sub(t, i)
print(s)
