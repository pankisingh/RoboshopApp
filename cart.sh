#!/usr/bin/bash
echo "Enter your name.."
read name
#read -p 'Enter your name ' name
echo "My name is $name"
var1=10;
var2=20;
var3=$((var1+var2));
echo "This is my total $var3"
No_of_users=$(who |wc -l)
echo No of users = $No_of_users
echo $0
echo $1
echo $*
echo $@