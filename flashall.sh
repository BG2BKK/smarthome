#!/bin/bash

cmd='python luatool.py -f SRC -t SRC'
x=$(ls *.lua)

luafile=(
#	'h_config.lua'
#	's_config.lua'
	'utils.lua'
	'dht11.lua'
	'oled.lua'
#	'wifi.lua'
#	'sock.lua'
#	'upload.lua'
#	'app.lua'
)


for f in "${luafile[@]}"
do 
	echo '============['$f']==========='
	c=${cmd//SRC/$f}

	flag=1
	while [ $flag -gt 0 ]
	do
		sleep 1
		echo $c
		echo $c | bash
		flag=$?
	done

	echo 'done'
	echo '-----------------------------'
	echo ''
done

echo 'python luatool.py -r -f init.lua -t init.lua ' | bash
