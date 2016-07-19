
ssid        = 'huang'
pwd         = 'sh19901222'

uart_debug = 1
oled_debug = 1
dev	= nil

if dev then
	server_ip   = '192.168.2.163'
	server_port = 8080 
	server_name = 'localhost'
	query_url   = '/smart'
else
	server_ip   = '45.78.38.250'
	server_port = 8080 
	server_name = 'localhost'
	query_url   = '/smart'
end

temp, hum = 0, 0
http_log = ''
user_input = ''

d_ip, d_temp, d_hum, d_upload = 2, 4, 6, 7
d_input = 9

display = {
	{ x = 0, y = 0,	data = 'ip: '	},
	{ x = 30,y = 0, data = ''    	},
	{ x = 0, y = 12,data = 'Temp: '	},
	{ x = 30,y = 12,data = ''		},
	{ x = 0, y = 24,data = 'Hum: '	},
	{ x = 30,y = 24,data = ''		},
	{ x = 0, y = 36,data = ''		},
	{ x = 0, y = 48,data = 'input: '},
	{ x = 36, y = 48,data = ''		},
}

broad_t = '/smart:broad'
lwt_t = '/smart:lwt:' 

sub_t = '/sub:' .. mac .. ':' chipid
pub_t = '/pub:' .. mac .. ':' chipid

