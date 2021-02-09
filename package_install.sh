#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
sudo ufw allow https comment 'Open all to access Nginx port 443'
sudo ufw allow http comment 'Open access Nginx port 80'
sudo ufw allow ssh comment 'Open access OpenSSH port 22'
sudo ufw enable
sudo ufw status
sudo apt-get install wget


