#!/bin/bash

NGINX_PID_PATH="/usr/local/nginx/logs/nginx.pid"

#Removing build artifacts
echo "Removing build artifacts"
rm -rf "$HOME/EZstreambuild"

#Stopping NGINX
if [ -f "$NGINX_PID_PATH" ]; then
        echo "Killing NGINX"
        kill -QUIT $(cat $NGINX_PID_PATH)
fi

#Remove NGINX files
echo "Removing NGINX files"
rm -rf "/usr/local/nginx"
