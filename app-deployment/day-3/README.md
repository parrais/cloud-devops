## Deploying our app

- `source app-deploy.sh` to deploy once script in place, no sudo needed
- Once reverse proxy in place, port 3000 no longer needed
- On restart, public IP may change (can be reserved in EC2 > Network & Security > Elastic IPs)

## DevOps

- Culture to bring teams together, avoid silos
- CAMSL pillars
  - Culture
  - Automation
  - Measurement
  - Sharing
  - Learning
- CI/CD: Continuous Integration/Continuous Deployment

![DevOps](Image20251119133626.png)

## MongoDB

- Name: se-matt-mongodb
- AMI: Ubuntu Server 24.04 LTS
- Instance type: t3.micro
- Key pair: se-matt-key-pair
- Network settings:
  - Name: se-matt-mongodb-sg
  - Rules: ssh and custom TCP 27017

On DB server:

1. `sudo apt update -y`
2. `sudo apt upgrade -y`
3. `sudo apt install gnupg -y`
4. `sudo apt install curl -y`
5. Get GPG key
   ```
   curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
   ```
6. Create sources list file - configures how to install mongodb
   `echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list`
7. `sudo apt update -y`
8. Install mongodb: `sudo apt install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 mongodb-org-server=7.0.6 mongodb-mongosh=2.1.5 mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6`
9. Check version with `mongod --version`
10. Check status with `sudo systemctl status mongod` (not running)
11. `cd /etc`
12. `sudo nano mongod.conf`
13. Change line `bindIp: 0.0.0.0`
14. Check with `cat mongod.conf`
15. `cd`
16. `sudo systemctl start mongod`
17. `sudo systemctl status mongod`

On app server:

18. `sudo nano .bashrc`
19. Add line `export DB_HOST=mongodb://DBIPADDRESS:27017/posts`
20. `source .bashrc`
21. Check with `printenv DB_HOST`
22. `pm2 kill`
23. `sudo npm install` (just in case)
24. `cd se-sparta-test-app/app`
25. `node seeds/seed.js`
26. `pm2 start app.js`
27. Check in browser at `http://APPIPADDRESS/posts`
