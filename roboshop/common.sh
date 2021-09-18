#!/bin/bash

USER_ID=$(id -u)
if [ $? -ne 0 ]; then
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
    exit 1
fi
}

PRINT()
{
    echo -n -e "$1\t\t... "
}