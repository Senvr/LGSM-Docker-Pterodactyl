FROM ubuntu:18.04 

#ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Senvrsoft, leeeyecard@gmail.com

RUN dpkg --add-architecture i386
RUN apt update -y
RUN apt upgrade -y
#RUN echo "postfix postfix/mailname string localhost" | debconf-set-selections
#RUN echo "postfix postfix/main_mailer_type string 'No configuration'" | debconf-set-selections
RUN apt install -y curl wget file tar bzip2 gzip unzip bsdmainutils python util-linux ca-certificates binutils bc jq tmux netcat lib32gcc1 lib32stdc++6 steamcmd zlib1g

RUN useradd -d /home/container -s /bin/bash -u 999 container

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
