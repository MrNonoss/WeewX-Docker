FROM python:3.10-slim-bullseye 

RUN pip install wheel paho-mqtt==2 weewx==5.0.2 ephem==4.1.5
RUN apt-get update && apt-get install rsyslog gosu -y && rm -rf /var/lib/apt/lists/*


RUN useradd -ms /bin/bash weewx
RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /home/weewx

RUN rsyslogd & gosu weewx weectl station create --no-prompt 
RUN rsyslogd & gosu weewx weectl extension install https://github.com/bellrichm/WeeWX-MQTTSubscribe/archive/refs/tags/v3.0.0-rc08.zip --yes
RUN rsyslogd & gosu weewx weectl extension install https://github.com/neoground/neowx-material/releases/download/1.11/neowx-material-1.11.zip --yes
RUN rsyslogd & gosu weewx weectl extension install https://github.com/teeks99/weewx-json/releases/download/v1.2/weewx-json_1.2.tar.gz --yes
RUN rsyslogd & gosu weewx weectl station reconfigure --no-prompt --no-backup

COPY entry.sh /home/weewx/entry.sh

ENTRYPOINT ["/home/weewx/entry.sh"]
