#!/bin/bash

source components/common.sh


echo -n "Configuring the MongoDB repo:"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $? 

echo "Installing Monogdb:"
yum install -y mongodb-org 
stat $? 

ech
systemctl enable mongod
systemctl start mongod