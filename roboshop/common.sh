#!/bin/bash

USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
    echo -n -e "\e[31mYou shoud be root or sudo user to run the script\e[0m"
    eixt 2
fi

LOG=/tmp/roboshop.log
#if previously any log is there it will delte and genrate new, 
#in case you want the history you can move it and store.
rm -f $LOG

STAT_CHECK(){
    if [ $1 -eq 0 ]; 
then 
    echo -e "\e[32mDone\e[m"
else
    echo -e "\e[31mFail\e[m"
    echo -e "\e[33mCheck the log file for more details - $LOG\e[0m"
    exit 1
fi
}

PRINT()
{
    echo -e "###################\t$1\t#################\t" &>>$LOG
    echo -n -e "$1\t\t... "
}