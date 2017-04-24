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
COPY ./epigenomegateway /home/epigenomegateway
CMD ["a2enmod", "cgi"]
CMD ["a2enmod", "headers"]
CMD ["service", "apache2", "restart"]
COPY ./run.sh /home/run.sh
CMD ["/home/run.sh"]
CMD ["service", "apache2", "restart"]
CMD ["service", "mysql", "start"]
EXPOSE 80
RUN cd /home
CMD sh ./run.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
