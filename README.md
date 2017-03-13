# EZ-StreamServer
Super easy streaming server setup

Current focus: Debian/Ubuntu

## Installation Instructions
Temporary install instructions until I can actually host the install scripts

    cd ~
    wget -qO - https://github.com/Scaless/EZ-StreamServer/archive/master.tar.gz | tar zx
    cd EZ-StreamServer-master
    chmod +x install.sh
    ./install.sh

## OBS Stream Settings

Stream must be x264 video/AAC audio to work with HLS.

OBS Settings:
    URL: rtmp://<IP_or_hostname>/HLS?123456
    Stream key: scalesstreamkey
