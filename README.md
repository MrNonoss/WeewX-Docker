Heavily based on the ver great work of vinceskahan (https://github.com/vinceskahan/weewx-docker).

/#####################\
|###--> GENESIS <--###|

#### Docker implementation of weewx:
#--> install from sources
#--> in interceptor mode (https://github.com/matthewwall/weewx-interceptor)
#--> with neowx skin (https://github.com/neoground/neowx)
#--> based on debian:stretch

/#########################\
|###--> PREQUISITES <--###|

#### You'll probably want to mount some files/directories to the container
#--> Config file: /home/weewx/weewx.conf
#--> Html: /home/weewx/public_html

/####################\
|###--> HOW TO <--###|

#### First, build the image
#--> docker build -t weewx .
#### Then create the container !!
#--> docker run -d -v $:/home/weewx/weewx.conf -v $$:/home/weewx/public_html weewx /home/weewx/bin/weewxd --daemon --pidfile=/var/run/weewx.pid /home/weewx/weewx.conf
#($=config file on your computer)
#($$=html directory on your computer)

/######################\
|###--> VERSIONS <--###|

#--> weewx: 3.9.1
#--> interceptor: 0.40
#--> neowx: 1.0
