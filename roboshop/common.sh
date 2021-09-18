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
    
    ADD_APP_USER
    
    Download_APP_Code

    
    PRINT "Installing Node Mangaer\t"
    cd /home/roboshop/${COMPONENT} &>>$LOG && npm install --unsafe-perm &>>$LOG
    STAT_CHECK $?

    Application_Permission

    SETUP_SYSTEMD

    START_SERVICE
}
START_SERVICE(){
    PRINT "Start ${COMPONENT} Service\t"
    systemctl daemon-reload &>>$LOG && systemctl restart ${COMPONENT} &>>$LOG && systemctl enable ${COMPONENT} &>>$LOG
    STAT_CHECK $?
}

ADD_APP_USER(){
PRINT "Add Application User\t"
    id=roboshop &>>$LOG
    if [$? -ne 0 ]; then
        useradd roboshop &>>$LOG
    fi
    STAT_CHECK $?

}

SETUP_SYSTEMD(){
    PRINT "Update SystemD file\t"
    sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' -e 's/AMQPHOST/rabbitmq.roboshop.internal/' -e 's/USERHOST/user.roboshop.internal/'  -e 's/DBHOST/mysql.roboshop.internal/' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/CARTHOST/cart.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/'  -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' /home/roboshop/${COMPONENT}/systemd.service && mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service
    STAT_CHECK $?
}

Application_Permission(){
    PRINT "Fix Application Permission"
    chown roboshop:roboshop /home/roboshop -R &>>$LOG
    STAT_CHECK $?
}

Download_APP_Code(){
    PRINT "Download ${COMPONENT} Archive"
    curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$LOG
    STAT_CHECK $?

    PRINT "Extract ${COMPONENT}\t"
    cd /home/roboshop && unzip /tmp/${COMPONENT}.zip &>>$LOG && rm -rf ${COMPONENT} && mv ${COMPONENT}-main ${COMPONENT} &>>$LOG
    STAT_CHECK $?
}

JAVA(){
    PRINT "Install Maven"
    yum install maven -y &>>$LOG
    STAT_CHECK $?

    ADD_APP_USER 

    Download_APP_Code

    PRINT "Compile Code"
      cd /home/roboshop/${COMPONENT} && mvn clean package &>>$LOG && mv target/shipping-1.0.jar shipping.jar 
    STAT_CHECK $?

    Application_Permission
    SETUP_SYSTEMD
    START_SERVICE
}

PYTHON3() {
  PRINT "Install Python3\t\t"
  yum install python36 gcc python3-devel -y &>>$LOG
  STAT_CHECK $?

  ADD_APPLICATION_USER
  DOWNLOAD_APP_CODE

  PRINT "Install Python Dependencies"
  cd /home/roboshop/${COMPONENT} && pip3 install -r requirements.txt &>>$LOG
  STAT_CHECK $?

  PRINT "Update Service Configuration"
  userID=$(id -u roboshop)
  groupID=$(id -g roboshop)
  sed -i -e "/uid/ c uid = ${userID}" -e "/gid/ c gid = ${groupID}" payment.ini &>>$LOG
  STAT_CHECK $?

  PERM_FIX
  SETUP_SYSTEMD
}