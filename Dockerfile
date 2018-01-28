FROM python:2
MAINTAINER Daniel Starzmann <daniel@starze.de>

RUN apt-get update \
 && apt-get install -y \
    wakeonlan \
 && rm -rf /var/lib/apt/lists/* 

WORKDIR /app
RUN pip install --no-cache-dir requests 
COPY hueUpnp_config.py hue-upnp-helper.sh hueUpnp.py wemo_control.sh /app/ 

EXPOSE 8080
VOLUME /app

CMD python /app/hueUpnp.py
