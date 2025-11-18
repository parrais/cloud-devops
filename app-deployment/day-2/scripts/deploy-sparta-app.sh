#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
wget https://github.com/parrais/cloud-devops/raw/refs/heads/main/app-deployment/day-2/files/nodejs20-se-test-app-2025.zip
sudo apt install unzip -y
sudo unzip nodejs20-se-test-app-2025.zip
sudo apt install nginx -y
sudo systemctl restart nginx
sudo systemctl enable nginx
sudo bash -c "curl -fsSL https://deb.nodesource.com/setup_20.x | bash -"
sudo apt install nodejs -y
cd ~/nodejs20-se-test-app-2025/app
sudo npm install
sudo npm install pm2 -g
pm2 --name SpartaApp start app.js