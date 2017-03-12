#!/bin/bash

#Packages needed to install everything
EZSTREAM_NEEDED_PACKAGES="build-essential libpcre3 libpcre3-dev libssl-dev wget git"
EZSTREAM_OPTIONAL_PACKAGES="mysql-server php-fpm php-mysql"
#Root paths for building files
EZSTREAM_ROOT="$HOME"
EZSTREAM_BUILD_PATH="$EZSTREAM_ROOT/EZstreambuild"
EZSTREAM_SOURCE_PATH="$HOME/EZ-StreamServer-master"
#Download locations
NGINX_TAR_PATH="https://nginx.org/download/nginx-1.11.10.tar.gz"
#NGINX_TAR_NAME=$(echo $NGINX_TAR_PATH | sed "s/.*\///")
NGINX_RTMP_TAR_PATH="https://github.com/arut/nginx-rtmp-module/archive/v1.1.11.tar.gz"
#NGINX_RTMP_TAR_NAME=$(echo $NGINX_RTMP_TAR_PATH | sed "s/.*\///")

MARIADB_PASSWORD="EZStreamDB"

#Begin installation
echo "Installing required packages"
apt-get -q update && apt-get -q install $EZSTREAM_NEEDED_PACKAGES -y

export DEBIAN_FRONTEND="noninteractive"
sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password password $MARIADB_PASSWORD"
sudo debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password $MARIADB_PASSWORD"
apt-get -q install $EZSTREAM_OPTIONAL_PACKAGES -y

mkdir $EZSTREAM_BUILD_PATH
cd $EZSTREAM_BUILD_PATH

echo "Downloading and extracting $NGINX_TAR_PATH"
mkdir "nginx" && wget -qO- $NGINX_TAR_PATH | tar xz -C "nginx" --strip-components=1

echo "Downloading and extracting $NGINX_RTMP_TAR_PATH"
mkdir "nginx-rtmp-module" && wget -qO- $NGINX_RTMP_TAR_PATH | tar xz -C "nginx-rtmp-module" --strip-components=1

#build nginx
cd "$EZSTREAM_BUILD_PATH/nginx"

echo "Configuring NGINX - see nginx_configure.log for details"
./configure --with-http_ssl_module --add-module="../nginx-rtmp-module" >>"$EZSTREAM_BUILD_PATH/nginx_configure.log" 2>&1

echo "Building NGINX - see nginx_make.log for details"
make >>"$EZSTREAM_BUILD_PATH/nginx_make.log" 2>&1

echo "Installing NGINX - see nginx_install.log for details"
make install >>"$EZSTREAM_BUILD_PATH/nginx_install.log" 2>&1

#Copy Default FIles
cp "$EZSTREAM_SOURCE_PATH/defaultfiles/index.html" "/usr/local/nginx/html/"

#start nginx
/usr/local/nginx/sbin/nginx
