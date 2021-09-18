#!/bin/bash

source common.sh

PRINT "Installing Redis Repos\t"
yum install epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>$LOG
STAT_CHECK $?

PRINT "Installing Redis\t\t"
yum install redis -y --enable remi &>>$LOG
STAT_CHECK $?

PRINT "Update Redis Listen Address"
sed -i -e 's/127.0.0.1/0.0.0.0' /etc/redis.conf  /etc/redis/redis.conf &>>$LOG
STAT_CHECK $?

PRINT "Start Redis Service\t"
systemctl enable redis &>>$LOG && systemctl start redis &>>$LOG
STAT_CHECK $?