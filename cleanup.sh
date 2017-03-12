#!/bin/bash

NGINX_PID_PATH="/usr/local/nginx/logs/nginx.pid"

#Removing build artifacts
echo "Removing build artifacts"
rm -rf "$HOME/EZstreambuild"
rm -rf "$HOME/EZ-StreamServer-master"

#Stopping NGINX
if [ -f "$NGINX_PID_PATH" ]; then
	echo "Killing NGINX"
	kill -QUIT $(cat $NGINX_PID_PATH)
fi

#Remove NGINX files
echo "Removing NGINX files"
rm -rf "/usr/local/nginx"

#Remove Go files
echo "Removing Go files"
rm -rf "$HOME/go"

rm $HOME/*.log
