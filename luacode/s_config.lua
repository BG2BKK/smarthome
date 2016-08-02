
ssid        = 'huang'
pwd         = 'sh19901222'

uart_debug = 1
oled_debug = 1
dev	= nil

if dev then
	s_ip   = '192.168.2.163'
	s_port = 8080 
	m_ip = '192.168.2.163'
	m_port = 1883
else
	s_ip   = '45.78.38.250'
	s_port = 8080 
	m_ip = '45.78.38.250'
	m_port = 1883
end

s_name = 'localhost'
path   = '/smart'


query_url = 'http://'..s_ip..':'..s_port..path

temp, hum = 0, 0
http_log = ''
user_input = ''

d_ip, d_temp, d_hum, d_upload = 2, 4, 6, 7
d_input, d_heap = 9, 11

display = {
	{  0,  0, 'ip: '	},
	{  30, 0,  ''    	},
	{  0,  12, 'Temp: '	},
	{  30, 12, ''		},
	{  60, 12, 'Hum: '	},
	{  90, 12, ''		},
	{  0,  36, ''		},
	{  0,  48, 'input: '},
	{  36,  48, ''		},
	{  0,  24,  'node:'	},
	{  30,  24, ''	},
}

clientid = mac .. ':' .. chipid
lwt_t = '/smart:lwt:' 
sub_t = '/smart/sub/' .. '/#' 
-- sub_t = '/smart/sub/' .. mac .. ':' .. chipid .. '/#' 
pub_t = '/smart/pub/' .. mac .. ':' .. chipid
m_is_connecting = false
m_is_subscribing = false

