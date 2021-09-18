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

NodeJs(){
    PRINT "Installing NodeJs\t"
    yum install nodejs make gcc-c++ -y &>>$LOG
    STAT_CHECK $?

    PRINT "Add Demon User\t"
    id=roboshop &>>$LOG
    if [$? -ne 0 ]; then
        useradd roboshop &>>$LOG
    fi
    STAT_CHECK $?

    PRINT "Download ${COMPONENT} Archive"
    curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$LOG
    STAT_CHECK $?

    PRINT "Extract ${COMPONENT}\t"
    cd /home/roboshop && unzip /tmp/${COMPONENT}.zip &>>$LOG && rm -rf ${COMPONENT} && mv ${COMPONENT}-main ${COMPONENT} &>>$LOG
    STAT_CHECK $?

    PRINT "Installing Node Mangaer\t"
    cd /home/roboshop/${COMPONENT} &>>$LOG && npm install --unsafe-perm &>>$LOG
    STAT_CHECK $?

    PRINT "Fix Application Permission"
    chown roboshop:roboshop /home/roboshop -R &>>$LOG
    STAT_CHECK $?

    PRINT "Update SystemD file\t"
    sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/'  -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' /home/roboshop/${COMPONENT}/systemd.service && mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
    STAT_CHECK $?


    PRINT "Start ${COMPONENT} Service\t"
    systemctl daemon-reload &>>$LOG && systemctl restart ${COMPONENT} &>>$LOG && systemctl enable ${COMPONENT} &>>$LOG
    STAT_CHECK $?

}