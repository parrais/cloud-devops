#!/bin/bash

# update packages
sudo apt update -y

# upgrade packages
sudo apt upgrade -y

# get and install nginx
sudo apt install nginx -y

# restart nginx
sudo systemctl restart nginx

#enable nginx - make nginx startup process
sudo systemctl enable nginx
