#!/bin/bash

# Wait for everything to be ready - User Data runs very fast! 
sleep 15

# user data runs as root!
cd /home/ubuntu

# cd to correct folder
cd se-sparta-test-app
cd app

# DB connection env var
export DB_HOST=mongodb://10.0.3.241:27017/posts

# npm install
sudo npm install

# seed database
node seeds/seed.js

# start app
pm2 start app.js