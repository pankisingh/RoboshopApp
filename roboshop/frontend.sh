#!/bin/bash

source common.sh
PRINT "installing Nginx"
yum install nginx -y &>>$LOG
STAT_CHECK $?

PRINT "Download Frontend"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG
STAT_CHECK $?

PRINT "Remove old HtDocs"
cd /usr/share/nginx/html && rm -rf * &>>$LOG
STAT_CHECK $?

PRINT "Extract Frontend Archive"
unzip /tmp/frontend.zip && mv frontend-main/* . && mv static/* . && rm -rf frontend-master static &>>$LOG
STAT_CHECK $?

PRINT "Update Roboshop Config"
mv localhost.conf /etc/nginx/default.d/roboshop.conf
STAT_CHECK $?

PRINT "Enabling Nginx\t"
systemctl enable nginx &>>$LOG 
STAT_CHECK $?

PRINT "Starting Nginx\t"
systemctl restart nginx &>>$LOG
STAT_CHECK $?