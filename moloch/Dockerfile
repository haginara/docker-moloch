FROM ubuntu:16.04
MAINTAINER haginara

ARG USERNAME="admin"
ARG PASSWORD="admin"

ENV USERNAME ${USERNAME}
ENV PASSWORD ${PASSWORD}

ENV UBUNTU_VERSION 16.04
ENV MOLOCH_VERSION 2.4.0-1

# MOLOCH IDS
# install prerequisites for moloch

RUN apt-get -qq update && apt-get -qq -y install curl
RUN apt-get -qq upgrade
RUN apt-get -y -qq install net-tools curl wget gdebi-core nodejs phantomjs

WORKDIR /tmp
# Get moloch
RUN curl -sL https://files.molo.ch/builds/ubuntu-${UBUNTU_VERSION}/moloch_${MOLOCH_VERSION}_amd64.deb -o moloch_${MOLOCH_VERSION}_amd64.deb
#RUN curl -sL https://s3.amazonaws.com/files.molo.ch/builds/ubuntu-${UBUNTU_VERSION}/moloch_${MOLOCH_VERSION}_amd64.deb -o moloch_${MOLOCH_VERSION}_amd64.deb
#install moloch debian package
RUN gdebi -n moloch_${MOLOCH_VERSION}_amd64.deb
RUN apt-get -qq upgrade && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add /data/moloch/bin to PATH
RUN echo "PATH=\"$PATH:/data/moloch/bin\"" > /etc/environment

# add moloch config
ADD /etc /data/moloch/etc

# add scripts
ADD /scripts /data
RUN chmod 755 /data/*.sh

RUN sed -i 's/USERNAME=.*/USERNAME=$USERNAME/' /data/startmoloch.sh
RUN sed -i 's/PASSWORD=.*/PASSWORD=$PASSWORD/' /data/startmoloch.sh

VOLUME ["/data/moloch/logs", "/data/moloch/data", "/data/moloch/raw", "/data/pcap"]

EXPOSE 8005
WORKDIR /data/moloch
CMD ["/data/startmoloch.sh"]
