#!/bin/bash
set -e   # ensure your script will stop if any of the instruction fails

source components/common.sh

echo "Installing Nginx: "
yum install nginx -y   >> /tmp/frontend.log 
if [ $? -eq 0 ] ; then 
    echo -e "\e[32m Success \e[0m" 
else
    echo -e "\e[31m Failure. Look for the logs \e[0m"  
fi 

systemctl enable nginx 

echo "Starting Nginx: "
systemctl start nginx 
if [ $? -eq 0 ] ; then 
    echo -e "\e[32m Success \e[0m" 
else
    echo -e "\e[31m Failure. Look for the logs \e[0m"  
fi 

echo "Downloading the Code"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
if [ $? -eq 0 ] ; then 
    echo -e "\e[32m Success \e[0m" 
else
    echo -e "\e[31m Failure. Look for the logs \e[0m"  
fi 


cd /usr/share/nginx/html
rm -rf *
unzip -o /tmp/frontend.zip >> /tmp/frontend.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

echo "Starting Ngnix: "
systemctl restart nginx
if [ $? -eq 0 ] ; then 
    echo -e "\e[32m Success \e[0m" 
else
    echo -e "\e[31m Failure. Look for the logs \e[0m"  
fi 

# source is a command to import a file and run it locally