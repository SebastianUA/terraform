#!/bin/bash -x

# CREATED:
# vitaliy.natarov@yahoo.com
#
# Unix/Linux blog:
# http://linux-notes.org
# Vitaliy Natarov
#

sudo yum update -y
sudo yum upgrade -y
sudo yum install epel-release -y

sudo yum install nginx -y

sudo service nginx restart
