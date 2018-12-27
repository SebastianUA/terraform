#!/bin/bash -x

sudo yum update -y 
sudo yum upgrade -y
sudo yum install -y \
	epel-release \
	htop \
	telnet \
	wget \
	curl \
	python34 \
	python34-pip \
	net-tools \
	vim \
	screen


sudo echo "Test user_data file" >> ~/tmp.txt
