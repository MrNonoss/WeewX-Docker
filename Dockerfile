#-------------------------------------------------------
# Dockerfile for building Weewx system
# With the interceptor driver and the neowx skin
#
#--> build via 'docker build -t weewx .'
#->> run via 'docker run -d weewx /home/weewx/bin/weewxd --daemon --pidfile=/var/run/weewx.pid /home/weewx/weewx.conf'
#
# last modified:
#     2019-0516 - First Commit
#     2019-0513 - Apprioriate by MrNonoss
#     2015-0220 - https://github.com/vinceskahan/weewx-docker - original
#
#-------------------------------------------------------
FROM debian:stretch
MAINTAINER Bruno BORDAS "bruno.bordas@gmx.com"

# copy the needed stuff to /tmp
COPY utils/ /tmp/

# install required packages
# cleanup of apt remnants courtesy of:
# https://gist.github.com/marvell/7c812736565928e602c4
RUN apt-get update && apt-get install -y sqlite3 wget supervisor tzdata curl procps nano python-dev python-pip python-configobj python-cheetah python-pil \
    && pip install pyephem \
    && apt-get clean autoclean && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

# install weewx via the setup.py method
RUN cd /tmp && tar zxvf /tmp/weewx-3.9.1.tar.gz && cd weewx-* ; ./setup.py build ; ./setup.py install --no-prompt && \
    cp /home/weewx/util/init.d/weewx.debian /etc/init.d/weewx && \
    mkdir -p /home/weewx/archive /home/weewx/public_html

# install the interceptor driver and the neowx skin from
# https://github.com/matthewwall/weewx-interceptor \ https://github.com/neoground/neowx
RUN /home/weewx/bin/wee_extension --install /tmp/weewx-interceptor.zip
RUN /home/weewx/bin/wee_extension --install /tmp/neowx-latest.zip
RUN /home/weewx/bin/wee_config --reconfigure --driver=user.interceptor --no-prompt

# Set timezone to Paris
RUN echo "Europe/Paris" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

CMD ["/bin/bash"]
