#!/bin/bash

source common.sh

PRINT "Installing NodeJs\t"
yum install nodejs make gcc-c++ -y &>>$LOG
STAT_CHECK $?

PRINT "Add Demon User\t"
id=roboshop &>>$LOG
if [$? -ne 0 ]; then
    useradd roboshop &>>$LOG
fi
STAT_CHECK $?

PRINT "Download Catalogue Archive"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG
STAT_CHECK $?

PRINT "Extract Catalogue\t"
cd /home/roboshop && unzip /tmp/catalogue.zip &>>$LOG && rm -rf catalogue && mv catalogue-main catalogue &>>$LOG &&
STAT_CHECK $?

PRINT "Installing Node Mangaer\t"
cd /home/roboshop/catalogue &>>$LOG && npm install --unsafe-perm &>>$LOG
STAT_CHECK $?

PRINT "Fix Application Permission"
chown roboshop:roboshop /home/roboshop -R &>>$LOG
STAT_CHECK $?

PRINT "Update SystemD file\t"
ser -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal' /home/roboshop/catalogue/systemd.service && mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
STAT_CHECK $?


PRINT "Start Catalogue Service\t"
systemctl daemon-reload &>>$LOG && systemctl start catalogue &>>$LOG && systemctl enable catalogue &>>$LOG
STAT_CHECK $?
