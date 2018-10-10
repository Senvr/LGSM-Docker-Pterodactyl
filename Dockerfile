FROM ubuntu:18.04 

#ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386
RUN apt update -y
RUN apt upgrade -y
RUN echo "postfix postfix/mailname string localhost" | debconf-set-selections
RUN echo "postfix postfix/main_mailer_type string 'No configuration'" | debconf-set-selections
RUN apt install -y mailutils postfix curl wget file bzip2 gzip unzip bsdmainutils python util-linux ca-certificates binutils bc jq tmux lib32gcc1 libstdc++6 libstdc++6:i386

RUN useradd -d /home/container -s /bin/bash -u 999 container

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
