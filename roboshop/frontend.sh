#!/bin/bash

echo -e "installing Nginx\t\t...\t\e[32mdone\0m"
yum install nginx -y

echo "Enabling Nginx"
systemctl enable nginx

echo "Starting Nginx"
systemctl start nginx
