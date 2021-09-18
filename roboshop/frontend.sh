#!/bin/bash
LOG=/tmp/roboshop.log

#if previously any log is there it will delte and genrate new, in case you want the history you can move it and store.
rm -f $LOG

STAT_CHECK(){
    if [ $1 -eq 0 ]; 
then 
    echo -e "\e[32mDone\e[m"
else
    echo -e "\e[31mFail\e[m"
    exit 1
fi

}
echo -n -e "installing Nginx\t\t\t... "
yum install nginx -y &>>$LOG
STAT_CHECK $?

echo -n -e "Enabling Nginx\t\t\t... "
systemctl enable nginx &>>$LOG 
STAT_CHECK $?

echo -n -e "Starting Nginx\t\t\t... "
systemctl start nginx &>>$LOG
STAT_CHECK $?