
-- timer --
wifi_interval   = 1000  -- ms
wifi_tmrid      = 0

dht11_interval  = 5000  -- ms
dht11_tmrid     = 1

oled_interval  = 1000  -- ms
oled_tmrid     = 4

conn_interval   = 30000 -- ms 
conn_tmrid      = 6

pm25_on_interval   = 5000
pm25_off_interval   = 20000
pm25_tmrid      = 5

-- port --
dht11_pin = 2
sda, scl, sla = 5, 6, 0x3c

-- nodemcu --
mac = wifi.sta.getmac()
chipid = node.chipid()
flashid = node.flashid()


