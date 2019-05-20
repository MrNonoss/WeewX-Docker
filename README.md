After hours of researches and many many tries, here is my version of weewx under docker.
Feel free to use as you like


/#####################\
|###--> GENESIS <--###|
----------------------
#### Docker implementation of weewx:
#--> install from apt
#--> in interceptor mode (https://github.com/matthewwall/weewx-interceptor)
#--> with neowx skin (https://github.com/neoground/neowx)
#--> based on debian:stretch

/#########################\
|###--> PREQUISITES <--###|
--------------------------
#### You'll probably want to mount some files/directories to the container
#--> $Config file: /etc/weewx/weewx.conf
#--> $$Html: /var/www/html/weewx
#--> $$$SQL: /var/lib/weewx

/####################\
|###--> HOW TO <--###|
----------------------
#### First, build the image
#--> docker build -t weewx .
#### Then create the container !!
#--> docker run -d -v $Config:/home/weewx/weewx.conf -v $$Html:/var/www/html/weewx -v $$$SQL:/var/lib/weewx weewx
(Change $Config / $$Html / $$$SQL according to your config )
