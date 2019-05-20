#-------------------------------------------------------
# Dockerfile for building Weewx system
# With the interceptor driver and the neowx skin
#
#--> build via 'docker build -t weewx .'
#->> run via 'docker run -d -v $weewx.conf:etc/weewx/weewx.conf -v $html:/var/www/html/weewx weewx'
#
# last modified:
#     2019-05-20 - First Commit
#
#-------------------------------------------------------
FROM debian:stretch
MAINTAINER Bruno BORDAS "bruno.bordas@gmx.com"

#############################
# Install Required Packages #
#############################

RUN apt-get update && apt-get full-upgrade -y \
    && apt-get install curl wget rsyslog procps gnupg -y

RUN wget -qO - http://weewx.com/keys.html | apt-key add - && wget -qO - http://weewx.com/apt/weewx.list | tee /etc/apt/sources.list.d/weewx.list \
    && apt-get update && apt-get install weewx -y && apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}

###################################
# Download and Install Extentions #
###################################

RUN cd /tmp && wget -O weewx-interceptor.zip https://github.com/matthewwall/weewx-interceptor/archive/master.zip && wget -O weewx-neowx.zip https://projects.neoground.com/neowx/download/latest \
    && wee_extension --install weewx-interceptor.zip && wee_extension --install weewx-neowx.zip && wee_config --reconfigure --driver=user.interceptor --no-prompt

#################
# Execute Weewx #
#################

CMD ["weewxd","/etc/weewx/weewx.conf"]
