
ssid        = 'huang'
pwd         = 'sh19901222'

debug = 1
if debug then
	server_ip   = '192.168.2.163'
	server_port = 8080 
else
	server_ip   = '45.78.38.250'
	server_port = 80 
end
server_name = 'localhost'
query_url   = '/smart'

mac = wifi.sta.getmac()
chipid = node.chipid()
flashid = node.flashid()

wifi_interval   = 1000  -- ms
wifi_tmrid      = 0

dht11_interval  = 5000  -- ms
dht11_tmrid     = 1

oled_interval  = 1000  -- ms
oled_tmrid     = 4

conn_interval   = 10000 -- ms 
conn_tmrid      = 6

pm25_on_interval   = 5000
pm25_off_interval   = 20000
pm25_tmrid      = 5

dht11_pin = 2
temp = 0
hum = 0

sda = 5
scl = 6
sla = 0x3c

d_ip		= 2
d_temp		= 4
d_hum		= 6
d_upload	= 7

display = {
	{ x = 0, y = 0,	data = 'ip: '	},
	{ x = 30,y = 0, data = ''    	},
	{ x = 0, y = 12,data = 'Temp: '	},
	{ x = 30,y = 12,data = ''		},
	{ x = 0, y = 24,data = 'Hum: '	},
	{ x = 30,y = 24,data = ''		},
	{ x = 0, y = 36,data = ''		},
}

http_log = ''

