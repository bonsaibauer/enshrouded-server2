#
# Enshrouded server Dockerfile
#
# https://github.com/bonsaibauer/enshrouded-server/blob/main/Dockerfile
#

# Pull base image.
FROM debian:latest

MAINTAINER bonsaibauer < mail@philippfeierabend.de >

ENV ENSHROUDED_VERSION 0.0.0

# Update & install packages
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y lsb-release wget cabextract winbind xvfb

RUN mkdir -pm755 /etc/apt/keyrings && \
    wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key && \
    wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bullseye/winehq-bullseye.sources && \
    apt-get update && \
    apt install -y --install-recommends winehq-stable

RUN useradd -ms /bin/bash enshrouded

USER enshrouded

RUN mkdir -p /home/enshrouded/steam/enshrouded && \
    usermod -u 1000 enshrouded

#Get steamcmd
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz -O /tmp/steamcmd_linux.tar.gz && \
    cd /tmp && \
    tar xf steamcmd_linux.tar.gz && \
    chmod +x steamcmd.sh && \
    ./steamcmd.sh +@sSteamCmdForcePlatformType windows +login anonymous +force_install_dir /home/enshrouded/steam/enshrouded +app_update 2278520 validate +exit

WORKDIR /home/enshrouded/steam/enshrouded

COPY enshrouded_server.json /home/enshrouded/steam/enshrouded/enshrouded_server.json

# Define volume for savegame
VOLUME ["/var/www/gameserver/enshrouded-server/savegame"]

# Update CMD to use the mounted volume for savegame
CMD ["sh", "-c", "ln -s /var/www/gameserver/enshrouded-server/savegame ./savegame && wine64 enshrouded_server.exe"]

CMD wine64 enshrouded_server.exe
