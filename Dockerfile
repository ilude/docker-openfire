FROM ubuntu:16.04
MAINTAINER Mike Glenn <mglenn@ilude.com>

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl unzip nano sudo openjdk-8-jre-headless

  
ENV OPENFIRE_VERSION=4.1.1 \
    OPENFIRE_USER=openfire \
    OPENFIRE_DATA_DIR=/var/lib/openfire \
    OPENFIRE_LOG_DIR=/var/log/openfire
  
RUN curl http://download.igniterealtime.org/openfire/openfire_${OPENFIRE_VERSION}_all.deb --output /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
  && dpkg -i /tmp/openfire_${OPENFIRE_VERSION}_all.deb \
  && mv /var/lib/openfire/plugins/admin /usr/share/openfire/plugin-admin \
  && rm -rf openfire_${OPENFIRE_VERSION}_all.deb \
  && rm -rf /var/lib/apt/lists/*
 
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3478/tcp 3479/tcp 5222/tcp 5223/tcp 5229/tcp 7070/tcp 7443/tcp 7777/tcp 9090/tcp 9091/tcp
VOLUME ["${OPENFIRE_DATA_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]