#!/bin/bash


source common.sh

PRINT "Setting Up MySql Repos\t"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo &>>$LOG
STAT_CHECK $?

PRINT "Install MySQL\t\t"
yum install mysql-community-server -y &>>$LOG
STAT_CHECK $?

PRINT "Start MySQL\t\t"
systemctl enable mysqld &>>$LOG && systemctl restart mysqld &>>$LOG
STAT_CHECK $?

PRINT "MySql Root Password Reset"
DEFAULT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print NF}')
echo "Show Database;" | mysql -uroot -pRoboShop@1 &>>$LOG 
if [ $? -ne 0 ]; then 
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql --connect-expired-password -uroot -p${DEFAULT_PASSWORD} &>>$LOG
fi
STAT_CHECK $?

PRINT "Uninstall Mysql Password Policy"
echo SHOW PLUGIN | mysql -uroot -pRoboShop@1 | grep -i validate_password &>>$LOG
if [ $? -eq 0 ]; then
    echo "uninstall plugin validate_password;" | mysql -uroot -pRoboShop@1 &>>$LOG
fi 
STAT_CHECK $?

PRINT "Download Schema"
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip" &>>$LOG
STAT_CHECK $?


PRINT "Load the schema for Services"
cd /tmp &>>$LOG && unzip mysql.zip &>>$LOG && cd mysql-main &>>$LOG && mysql -uroot -pRoboShop@1 <shipping.sql &>>$LOG
STAT_CHECK $?