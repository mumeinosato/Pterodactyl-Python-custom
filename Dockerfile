FROM        python:3.10-slim

LABEL       author="Michael Parker" maintainer="parker@pterodactyl.io"

RUN         apt-get update -y && apt-get -y install apt-utils \
                curl \
                ffmpeg \ 
                apt-transport-https \
                ca-certificates \
                wget \
                tar \
                ffmpeg \
                dirmngr \
                gnupg \
                iproute2 \
                libopus0 \
                make \
                g++ \
                locales \
                git \
                cmake \
                zip \
                unzip \
                libtool-bin \
                autoconf \
                automake \
                libsodium-dev \
                build-essential \
                libncursesw5-dev \
                libssl-dev \
                libsqlite3-dev \
                tk-dev \
                libgdbm-dev \
                libc6-dev \
                libbz2-dev \
                libffi-dev \
                zlib1g-dev  \
                python3-dev \
                default-libmysqlclient-dev \
            && useradd -d /home/container -m container

ENV         LANG=en_US.UTF-8

ENV         TZ=JST

RUN         ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN         apt update && apt-get install -y --no-install-recommends \
                build-essential \
                ca-certificates \
                curl \
                git \
                libbz2-dev \
                libffi-dev \
                libncurses5-dev \
                libncursesw5-dev \
                libreadline-dev \
                libsqlite3-dev \
                liblzma-dev \
                libssl-dev \
                llvm \
                make \
                netbase \
                pkg-config \
                tk-dev \
                wget \
                xz-utils \
                zlib1g-dev \
                zlib1g-dev \
                python3-dev \
                default-libmysqlclient-dev \
            && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY        ./start.sh /start.sh
RUN         chmod +x /start.sh

RUN         apt clean && rm -rf /var/cache/apt/archives && rm -rf /var/lib/apt/lists/*

USER        container
ENV         USER=container 
ENV         HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]