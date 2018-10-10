FROM ubuntu:18.04 

#ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386
RUN apt update -y
RUN apt upgrade -y
RUN echo "postfix postfix/mailname string localhost" | debconf-set-selections
RUN echo "postfix postfix/main_mailer_type string 'No configuration'" | debconf-set-selections
RUN apt install -y mailutils postfix curl wget file bzip2 gzip unzip bsdmainutils python util-linux ca-certificates binutils bc jq tmux lib32gcc1 libstdc++6 libstdc++6:i386

RUN useradd -m -d /home/container container

USER container
ENV HOME /home/container
ENV TERM=xterm
WORKDIR /home/container

#RUN wget -O linuxgsm.sh https://linuxgsm.sh \
#	&& chmod +x linuxgsm.sh \
#	&& bash linuxgsm.sh arma3servr
#USER root

#RUN mkdir -p lgsm/config-lgsm/arma3server
#RUN echo "steamuser='' \n steampass=''" > \
#	lgsm/config-lgsm/arma3server/common.cfg 

#RUN chown container:container \
#	/home/container
#RUN chmod -R 777 \
#	/home/container 

#USER container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
