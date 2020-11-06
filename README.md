# UPDATE TO 4.2.0

After hours of researches and many many tries, here is my version of weewx under docker.
I use this with an Ambient Weather Station WS-2902 and a PiHole docker container (https://pi-hole.net/)

I modified the /etc/hosts file of the PiHole so that my local dns forward all the data send to rtupdate.wunderground.com to my weewx-core. The line I have to add looks like: 192.168.X.X	rtupdate.wunderground.com weewx
Where the IP is the one of the weewx-core I settle in the docker-compose file.

With this, you'll get:
- WeeX 4.2.0 installed from sources, with:
- The Neowx theme (https://github.com/neoground/neowx)
- The Interceptor driver (https://github.com/matthewwall/weewx-interceptor)
- Installed in a docker Image based from Debian:stretch
- With a custom macvlan driver for docker, in order to avoid IP/ports conflicts
- weewx-core will listen on port 80 in the macvlan and retrieve the datas
- weewx-web will listen on port 8080 in the regular network driver and will expose the weather in a nice nginx web page

Since I use Home-Assistant at home (https://www.home-assistant.io), I tweaked the skin thanks to the community:
https://community.home-assistant.io/t/weather-station-data/58489/12?u=mrnonoss
Meaning I add one file an modify another, in order to get the data directly to my dashboard.

I provide with a docker-compose, running two services:
- weewx-core (the weewx install)
- weewx-web (an nginx web-server)

You'll probably want to mount some files/directories inside the container to keep data, so adapt the docker-compose to your needs:
- ${PWD}/data/weewx.conf:/home/weewx/weewx.conf # Be sure to review it if you switch from apt/deb install to sources
- ${PWD}/data/html/:/home/weewx/public_html/
- ${PWD}/data/archive:/home/weewx/archive/

How to use:
- First, git clone the repo:
git clone https://github.com/MrNonoss/weewx.git
- Change directory and create the network:
cd weewx/network && docker-compose up
- Change directory and create the image:
cd .. && docker build -t weewx .
- Then, rename the docker-compose and run it:
docker-compose up

Feel free to use it as ou like !

PS: I uploaded an genuine weex.conf file to help.
