#!/bin/bash
LOG=/tmp/roboshop.log

#if previously any log is there it will delte and genrate new, in case you want the history you can move it and store.
rm -f $LOG
echo -n -e "installing Nginx\t\t..."
yum install nginx -y &>>$LOG
if [ $? -eq 0 ]; 
then 
    echo -e "\e[32mDone\e[m"
else
    echo -e "\e[32mFail\e[m"
fi

echo "Enabling Nginx"
systemctl enable nginx &>>$LOG 

echo "Starting Nginx"
systemctl start nginx &>>$LOG
