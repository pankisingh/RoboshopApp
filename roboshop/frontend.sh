#!/bin/bash

echo -e "installing Nginx\t\t...\tdone"
yum install nginx -y

echo "Enabling Nginx"
systemctl enable nginx

echo "Starting Nginx"
systemctl start nginx
