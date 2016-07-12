local moduleName = ...
local M = {}
_G[moduleName] = M


function M.listFile()
    local fl = file.list()
    for k, v in pairs(fl) do
        print(k , v)
    end
end
