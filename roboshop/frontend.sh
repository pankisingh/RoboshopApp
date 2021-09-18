#!/bin/bash
LOG=/tmp/roboshop.log
echo -e "installing Nginx\t\t...\t\e[32mdone\e[m"
yum install nginx -y >$LOG

echo "Enabling Nginx"
systemctl enable nginx >$git 

echo "Starting Nginx"
systemctl start nginx >$LOG
