FROM phusion/baseimage:0.9.21
MAINTAINER Deepak Purushotham "dpurushotham136@gmail.com"

CMD ["/sbin/my_init"]
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && apt-get install -y make \
  gcc \
  apache2 \
  mysql-server \
  libmysqlclient-dev \
  libmysqld-dev \
  unzip \
  r-base \
  lib32z1-dev \
  lib32ncurses5-dev \
  librsvg2-bin \
  wget \
  git \
  curl
WORKDIR /home

RUN wget http://curl.haxx.se/download/curl-7.46.0.tar.bz2
RUN tar -xvjf curl-7.46.0.tar.bz2
RUN cd curl-7.46.0 && make
RUN cd curl-7.46.0 && make install

COPY ./epigenomegateway /home/artifacts/epigenomegateway
RUN mkdir /var/www/html/data
RUN mkdir /var/www/html/datahub
COPY ./LUAD_datahub.json /var/www/html/datahub
COPY ./pigment_datahub.json /var/www/html/datahub
COPY ./LUAD_download_list.sh /home/artifacts
COPY ./pigment_download_list.sh /home/artifacts
COPY ./run.sh /home/run.sh

EXPOSE 80


RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
