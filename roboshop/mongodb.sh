#!/bin/bash

source common.sh
PRINT "Setting Up Repository\t"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
STAT_CHECK $?

PRINT "Installing MongoDB\t\t"
yum install -y mongodb-org &>>$LOG
STAT_CHECK $?

PRINT "Update MongoDB Listen Address\t"
sed -i -e 's/127.0.0.1/0.0.0.0/'  /etc/mongod.conf
STAT_CHECK $?

PRINT "Enabling MongoDB\t\t"
systemctl enable mongod &>>$LOG
STAT_CHECK $?

PRINT "Start MongoDB\t\t"
systemctl start mongod
STAT_CHECK $?

PRINT "Downloading Schema\t"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>$LOG
STAT_CHECK $?

PRINT "Load Schema\t\t"
cd /tmp && unzip -o mongodb.zip &>>$LOG && cd mongodb-main &>>$LOG && mongo < catalogue.js &>>$LOG && mongo < users.js &>>$LOG
STAT_CHECK $?

PRINT "Retart MongoDB\t\t"
systemctl restart mongod 
STAT_CHECK $?


