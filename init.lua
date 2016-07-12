require("cjson")
require("config")
require("dht11")
require("sock")
require("upload")
require("oled")
require("app")

print('init.lua ver 1.2')
print('MAC: ', mac)
print('chip: ', chipid)
print('flashid: ', flashid)

app.init()
app.run()
