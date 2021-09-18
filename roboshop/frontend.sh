#!/bin/bash
LOG=/tmp/roboshop.log

#if previously any log is there it will delte and genrate new, in case you want the history you can move it and store.
rm -f $LOG
echo -e "installing Nginx\t\t...\t\e[32mdone\e[m"
yum install nginx -y >>$LOG

echo "Enabling Nginx"
systemctl enable nginx >>$LOG 

echo "Starting Nginx"
systemctl start nginx >>$LOG
