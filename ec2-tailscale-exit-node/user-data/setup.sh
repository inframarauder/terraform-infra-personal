#!/bin/bash

set -eux

# update packages
sudo apt-get update -y

# set hostname
sudo hostnamectl set-hostname "${hostname}"

# Install Tailscale on Ubuntu 22.04
curl -fsSL https://tailscale.com/install.sh | sh

# Enable IP forwarding
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf

# Enable Tailscale as exit node
sudo tailscale up --authkey "${tailscale_authkey}" --hostname "${hostname}" --advertise-exit-node 