#!/bin/bash

cd $HOME
wget -qO - https://github.com/Scaless/EZ-StreamServer/archive/master.tar.gz | tar zx
cd EZ-StreamServer-master
chmod +x install.sh
./install.sh
