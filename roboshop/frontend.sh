#!/bin/bash
LOG=/tmp/roboshop.log

#if previously any log is there it will delte and genrate new, in case you want the history you can move it and store.
rm -f $LOG
echo -n -e "installing Nginx\t\t\t..."
yum install nginx -y &>>$LOG
if [ $? -eq 0 ]; 
then 
    echo -e "\t\e[32mDone\e[m"
else
    echo -e "\t\e[31mFail\e[m"
    exit 1
fi

echo -e "Enabling Nginx\t\t\t..."
systemctl enable nginx &>>$LOG 

echo -e "Starting Nginx\t\t\t..."
systemctl start nginx &>>$LOG
