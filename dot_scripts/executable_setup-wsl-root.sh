#!/bin/sh
# prep WSL Ubuntu, run as root

apt update
apt upgrade

apt install \
  apt-transport-https \
  aptitude
  ca-certificates \
  curl \
  fish \
  gnupg-agent \
  software-properties-common

# Install official docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update
apt install docker-ce docker-ce-cli containerd.io
