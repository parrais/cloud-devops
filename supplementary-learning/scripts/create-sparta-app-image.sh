#!/bin/bash
apt update -y && apt upgrade -y

apt install git sed nginx curl -y

git clone https://github.com/LSF970/nodejs2-sparta-test-app-2025.git

sed -i '51c\proxy_pass http://127.0.0.1:3000;' /etc/nginx/sites-available/default

systemctl restart nginx
systemctl enable nginx

bash -c "curl -fsSL https://deb.nodesource.com/setup_20.x | bash -"

apt install nodejs -y

npm install pm2 -g