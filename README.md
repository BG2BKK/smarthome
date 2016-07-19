# nodemcu_smarthome

* firmware
	* nodemcu-master-18-modules-2016-07-16-08-39-43-float.bin
		* http://nodemcu-build.com/
	* moudles: adc, bit, cjson, dht, enduser_setup, file, gpio, http, i2c, mqtt, net, node, pwm, struct, tmr, u8g, uart, wifi.
	* [esptool.py](https://github.com/themadinventor/esptool)
		* [how to burn the lateset firmware](http://tinylab.org/nodemcu-kickstart/)

```bash
sudo ../esptool/esptool.py --port /dev/ttyUSB0 --baud 230400 write_flash -fm dio -fs 32m -ff 40m 0x00000 ./pre_build/latest/nodemcu_latest.bin
```

* esplorer
	* [how to upload lua code file to nodemuc](https://github.com/4refr0nt/ESPlorer)

* luacode
	* [h_config.lua](luacode/h_config.lua)
		* configuration of hardware, such as timer, pin
	* [s_config.lua](luacode/s_config.lua)
		* configuration of software, such as content of oled, post data of http request
	* [init.lua](luacode/init.lua)
		* init file
	* [app.lua](luacode/app.lua)
		* app router
	* [dht11.lua](luacode/dht11.lua)
		* wrapper of dht11, based on dht.lib of firmware
	* [oled.lua](luacode/oled.lua)
		* oled of ssd1306_128x64 and u8g.font_6x10, based on u8g lib
	* [remote.lua](luacode/remote.lua)
		* send request to remote server
	* [sock.lua](luacode/sock.lua)
		* base lib of net.tcp (deprecated) 
	* [upload.lua](luacode/upload.lua)
		* heartbeat and upload statistics to remote server
	* [utils.lua](luacode/utils.lua)
		* utils such as log function

* snippet
	* snippets of lua code on nodemcu

* nginx
	* http server: nginx
		* conf/nginx.conf
	* web app
		* [nginx/luacode](nginx/luacode)

