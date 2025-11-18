## Running bash scripts on EC2

- Use `sudo nano ` and name of script to write bash script onto server
- `sudo chmod +x ` and name of script to set permissions
- `./` and name of script to run
- Check in terminal with `sudo systemctl status nginx`, quit to terminal (if needed) with `q` or `ctrl-c`

## Transferring files to EC2

Upload with:

```
scp -i ~/.ssh/se-matt-key-pair.pem nodejs20-se-test-app-2025.zip ubuntu@ec2-108-130-162-137.eu-west-1.compute.amazonaws.com:~
```

## App deployment manual steps

Before you run these commands you must:

- Create an EC2 instance
  - It must have an SG that has ports 22, 80 and 3000 open
- Copy the app code as a zip to your EC2 instance, using SCP
  - example: `scp -i ~/.ssh/se-luke-key-pair.pem "nodejs20-se-test-app-2025.zip" ubuntu@34.244.245.244:~`

If the above has been done, follow the following guide:

1. `sudo apt update -y`
   - This downloads newest versions of packages
2. `sudo apt upgrade -y`
   - This installs latest version available
3. `sudo apt install unzip -y`
   - Package for unzipping files
4. `sudo unzip nodejs20-se-test-app-2025.zip`
   - Unzips folder so it can be used
5. `sudo apt install nginx -y`
   - Installs and runs nginx
   - `sudo systemctl status nginx` to check
6. `sudo bash -c "curl -fsSL https://deb.nodesource.com/setup_20.x | bash -"`
   - Get specific version of Nodejs downloaded
   - Not installed yet
7. `sudo apt install nodejs -y`
   - Install nodejs 20
   - `node -v` to check version
8. `cd ~/nodejs20-se-test-app-2025/app`
9. `sudo npm install`
   - Installs npm libraries needed for app to run
10. `npm start app.js`
    - Starts app, runs in foreground
    - Thus will take away terminal access
11. Check your public IP address to see if Sparta app is working
    - e.g. `http://3.134.41.67:3000`
