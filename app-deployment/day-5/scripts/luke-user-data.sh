#!/bin/bash

# Wait for everything to be ready - User Data runs very fast!
sleep 15

# user data runs as root!
cd /home/ubuntu

# cd to correct folder
cd se-sparta-test-app
cd app

# npm install
sudo npm install

# start app
pm2 start app.js