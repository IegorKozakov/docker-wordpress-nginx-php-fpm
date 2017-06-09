#!/bin/sh

# update packages
yum update -y

# install docker
curl https://get.docker.com/ | sh
usermod -aG docker vagrant
systemctl enable docker
systemctl start docker

# install docker-compose
easy_install pip
pip install docker-compose
