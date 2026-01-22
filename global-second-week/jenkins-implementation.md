# Jenkins Implementation

## Simple implementations

### Basic Implementation

Jenkins:

- New Item
- Enter an item name: `(name)-(description)`, Freestyle project, OK
- Configure:
  - Description: `(Enter description)`
  - Discard old builds: tick
  - Strategy: Log Rotation
  - Max # of builds to keep: `3`
  - Restrict where this project can be run: untick
  - Build Steps: Add build step, Execute shell

    ![Add build step, Execute Shell](screenshots/add-build-step.png)

  - Command: `uname -a`
  - Save

- Build Now

### Chaining Jenkins projects

Two ways to do this:

1. In the first project:
   - Add post-build action
   - Build other projects
   - Add second project

     ![Add post-build action, Build other projects](screenshots/add-post-build-action.png)

2. In the second project:
   - Build Triggers:
   - Build after other projects are built: tick
   - Projects to watch: Add first project

     ![Build after other projects are built](screenshots/build-after-other-projects.png)

## Jenkins - GitHub (CI/CD)

GitHub:

- Create new blank, private repo

Local:

- Set up local repo
  - `git clone` repo
  - Add app to repo
  - `git add`, `git commit`, `git push` repo

- Create SSH key pair:
  - `cd ~/.ssh`
  - `ssh-keygen -t rsa -b 4096 -C "mlewis@spartaglobal.com"`
  - Name: `tech519-matt-jenkins-github-key`
  - No passphrase

Github:

- Go to repo > Settings > Security > Deploy keys > Add deploy key
- Add new:
  - Title `jenkins-cicd-key`
  - Key: Contents of `tech519-matt-jenkins-github-key.pub` (including `ssh-rsa` at start and email at end)
  - Allow write access: tick
  - Add key
- Go to repo > Settings > Webhooks > Add webhook
- Add webhook:
  - Payload URL: `http://(jenkins-server-ip):8080/github-webhook/`
  - SSL verification: Disable (for testing)
  - Add webhook

Jenkins:

- New Item
- Enter an item name: `(name)-(description)`, Freestyle project, OK
- Configure:
  - Description: `(Enter description)`
  - Discard old builds: tick
  - Strategy: Log Rotation
  - Max # of builds to keep: `3`
  - GitHub project: tick
  - Project url: `(HTTPS URL from GitHub repo, with trailing slash)`
  - Restrict where this project can be run: untick
  - Source Code Management: Git
  - Repository URL: `(SSL URL from GitHub repo)`(❗Ignore red warning text❗)
  - Credentials: Add, Jenkins
  - Add Credentials:
    - Kind: SSH Username with private key
    - ID, Description, Username: `tech519-matt-github-key`
    - Private Key: Enter directly
    - Key: Add
    - Paste in private key (including `-----BEGIN OPENSSH PRIVATE KEY-----` and `-----END OPENSSH PRIVATE KEY-----`)
    - Add
  - Branch Specifier: `*/main`

    ![Source Code Management](screenshots/source-code-management.png)

  - Provide Node & npm bin/ folder to PATH: tick
  - NodeJS Installation: NodeJS version 20
  - Build Steps: Add build step, Execute shell
  - Command:
    ```
    ls
    cd app
    ls
    npm install
    npm test
    ```
  - Save

- Build Now

### Webhook

Jenkins:

- Configure:
  - Build Triggers
    - GitHub hook trigger for GITScm polling: tick
  - Source Code Management Git - Branches to build
    - Branch Specifier: `*/dev`
  - Save

### Testing

Local:

- `git checkout -b dev`
- Make local change
- `git add`, `git commit`, `git push`

Jenkins build triggered, data pushed to `dev` branch on GitHub.

### Merge

Local (to check process, with pushed commits to dev):

- `git checkout main`
- `git merge dev`
- `git push -u origin main`

Jenkins:

- New item
- Copy from: `(job1)` _(to avoid need to replicate authentication setup)_
- Configure:
  - Description: `Merge dev branch into main branch`
  - Build Triggers:
    - GitHub hook trigger for GITScm polling: untick
    - Build after other projects are built: `(job1)`
    - Trigger only if build is stable: select
  - Build Steps:
    - Delete build steps
  - Post-build Actions
    - Add post-build action: Git Publisher
    - Push Only If Build Succeeds: tick
    - Merge Results: tick
    - Branches - Add Branch
    - Branch to push: `main`
    - Target remote name: `origin`
  - Save

Local (to test):

- `git checkout dev`
- Make local change
- `git add`, `git commit`, `git push`

### Continuous Delivery

AWS:

- Make EC2 app instance and note public IP address

Jenkins:

- New Item
- Enter an item name: `(name)-(description)`
- Copy from: `(job2)` _(to avoid need to replicate authentication setup)_, OK
- Configure:
  - Description: `(Enter description)`
  - Build Triggers:
    - Build after other projects are built: `(job2)`
    - Trigger only if build is stable: select
  - Post-build Actions
    - Delete Git Publisher
  - Build Environment
    - SSH Agent
      - Credentials: Add, Jenkins
        - Add Credentials:
          - Kind: SSH Username with private key
          - ID, Description, Username: `tech519-matt-aws-key`
          - Private Key: Enter directly
          - Key: Add
          - Paste in AWS private key (including `-----BEGIN OPENSSH PRIVATE KEY-----` and `-----END OPENSSH PRIVATE KEY-----`)
          - Add
  - Build Steps: Add build step, Execute shell
    - Command:
      ```
      rsync -avz -e "ssh -o StrictHostKeyChecking=no" app ubuntu@(AWS_EC2_IP_ADDRESS):/home/ubuntu
      ssh -o "StrictHostKeyChecking=no" ubuntu@(AWS_EC2_IP_ADDRESS) <<EOF
        ls
        cd app
        ls
      EOF
      ```
  - Save

Local (to test):

- `git checkout dev`
- Make local change
- `git add`, `git commit`, `git push`

### Continuous Deployment

Jenkins:

- Edit CD job shell command:

  ```
  rsync -avz -e "ssh -o StrictHostKeyChecking=no" app ubuntu@(AWS_EC2_IP_ADDRESS):/home/ubuntu

  ssh -o "StrictHostKeyChecking=no" ubuntu@(AWS_EC2_IP_ADDRESS) <<EOF
    ls
    cd app
    ls
    npm install
    pm2 kill
    pm2 start app.js
  EOF
  ```

Local (to test):

- `git checkout dev`
- Make local change
- `git add`, `git commit`, `git push`
