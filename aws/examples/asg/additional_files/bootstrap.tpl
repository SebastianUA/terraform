#!/bin/bash

sudo yum update -y;
sudo yum install -y epel-release.noarch;
sudo yum update -y;
sudo yum install -y htop \
	telnet \
	wget \
	curl \
	python34 \
	python34-pip \
	net-tools \
	vim \
	screen
   
sudo yum update -y;
 
sudo echo "Test user_data file" >> ~/tmp.txt
