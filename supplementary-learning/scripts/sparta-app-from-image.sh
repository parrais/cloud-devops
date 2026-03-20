#!/bin/bash
cd nodejs2-sparta-test-app-2025/app

export DB_HOST=mongodb://<db-private-ip>:27017/posts

npm install

pm2 start app.js