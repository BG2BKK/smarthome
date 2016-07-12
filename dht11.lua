local moduleName = ...

local M = {}

_G[moduleName] = M

local hum = 0
local hum_min = 0
local temp = 0
local temp_min = 0

local bitStream = {}

function M.init(pin)

    bitStream = {}
    for j = 1, 40, 1 do
        bitStream[j] = 0
    end
    bitlength = 0

    gpio.mode(pin, gpio.OUTPUT)
    gpio.write(pin, gpio.LOW)
    tmr.delay(20000)
    gpio_read = gpio.read
    gpio_write = gpio.write

    gpio.mode(pin, gpio.INPUT)

    while (gpio_read(pin) == 0) do end

    c = 0
    while (gpio_read(pin) == 1 and c < 100) do c = c + 1 end

    while (gpio_read(pin) == 0) do end

    c = 0
    while (gpio_read(pin) == 1 and c < 100) do c = c + 1 end

    for j = 1, 40, 1 do
        while (gpio_read(pin) == 1 and bitlength < 10) do
            bitlength = bitlength + 1
        end
        bitStream[j] = bitlength
        bitlength = 0
        while (gpio_read(pin) == 0) do end
    end

    hum = 0
    temp = 0

    hum_min = 0
    temp_min = 0

    for i = 1, 8, 1 do
        if (bitStream[i + 0] > 2) then
            hum = hum + 2 ^ (8 - i)
        end
    end

    for i = 1, 8, 1 do
        if (bitStream[i + 8] > 2) then
            hum_min = hum_min + 2 ^ (8 - i)
        end
    end

    for i = 1, 8, 1 do
        if (bitStream[i + 16] > 2) then
            temp = temp + 2 ^ (8 - i)
        end
    end

    for i = 1, 8, 1 do
        if (bitStream[i + 24] > 2) then
            temp_min = temp_min + 2 ^ (8 - i)
        end
    end

    hum_min = hum_min * 100 / 256
    temp_min = temp_min * 100 / 256

    bitStream = {}
    gpio_read = nil
    gpio_write = nil
end

function M.getRaw()
end

function M.getTemp()
    return temp + temp_min
end

function M.getHumidity()
    return hum + hum_min
end

return M
