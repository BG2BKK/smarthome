sudo ./esptool.py --port /dev/ttyUSB0 --baud 230400 write_flash -fm dio -fs 32m -ff 40m 0x00000 ./pre_build/latest/nodemcu_latest.bin 

srec_cat -output nodemcu.bin -binary ./bin/0x00000.bin -binary -fill 0xff 0x00000 0x10000 ./bin/0x10000.bin -binary -offset 0x10000

awk '{print "sudo ./luatool.py -p /dev/ttyUSB0 -f "$1}' filelist | sudo bash
