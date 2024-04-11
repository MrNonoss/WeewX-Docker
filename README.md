# WeeWX 5 + MQTT Driver + NeoWX-Material + Homebridge JSON 

Based on https://github.com/MrNonoss/WeewX-Docker

With this, you'll get:
[WeeWX 5](https://github.com/weewx/weewx) installed from pip, with:
- The [Neowx-material theme](https://github.com/neoground/neowx-material)
- The [MQTT Subscribe driver](https://github.com/bellrichm/WeeWX-MQTTSubscribe)
- The [JSON Driver](https://github.com/teeks99/weewx-json), with a template for [homebridge-weather-plus](https://github.com/naofireblade/homebridge-weather-plus). 
- Installed in a docker Image
- The files are written back to the mounted drive, in my case for another app to publish them to a website. 



You'll probably want to mount some files/directories inside the container to keep data. You can adjust as you need. 

Running:
`docker-compose up`


Note: For now, I have the simulator plugin enabled as the only plugin. You will need to manually configure the MQTT Subscribe Driver and enable it for your use case. 
