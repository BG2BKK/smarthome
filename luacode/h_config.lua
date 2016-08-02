
-- timer --
wifi_int	= 500  -- ms
wifi_tid	= 0

dht11_int  = 5000  -- ms
dht11_tid     = 1

oled_int  = 1000  -- ms
oled_tid     = 4

mqtt_int  = 30000  -- ms
mqtt_tid     = 2

conn_int   = 30000 -- ms 
conn_tid      = 6

-- port --
dht11_pin = 2
sda, scl, sla = 5, 6, 0x3c

-- nodemcu --
mac = wifi.sta.getmac()
chipid = node.chipid()
flashid = node.flashid()


