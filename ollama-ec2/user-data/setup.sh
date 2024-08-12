#!/bin/bash

set -eux

# update packages
sudo apt-get update -y

# set hostname
sudo hostnamectl set-hostname "${hostname}"

# install docker
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
apt-cache policy docker-ce
sudo apt-get install docker-ce -y
sudo systemctl status docker

# add the ssh user to the docker group
sudo usermod -aG docker "${ssh_username}"

# check docker version installed - 
docker info

# pull ollama docker image
docker pull ollama/ollama

# run ollama image (cpu-only)
docker run -d -v ollama:/root/.ollama -p 80:11434 --name ollama ollama/ollama
