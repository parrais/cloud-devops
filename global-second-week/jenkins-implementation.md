# Jenkins Implementation

## Basic Implementation

Jenkins:

- New Item
- Enter an item name: `(name)-(description))`, Freestyle project, OK
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

## Chaining Jenkins projects

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

## Jenkins - GitHub

GitHub:

- Create new blank, private repo

Local:

- Set up local repo
  - `git clone` repo
  - Add app to repo
  - `git push` repo

- Create SSH key pair:
  - `cd ~/.ssh`
  - `ssh-keygen -t rsa -b 4096 -C "mlewis@spartaglobal.com"`
  - Name: `tech519-matt-jenkins-github-key`
  - No passphrase

Github:

- Go to repo > Settings > Security > Deploy keys > Add deploy key
- Add new:
  - Title `jenkins-cicd-key`
  - Key: Contents of `tech519-matt-jenkins-github-key.pub` (including 'ssh-rsa' at start and email at end)
  - Allow write access: tick
  - Add key
- Go to repo > Settings > Webhooks > Add webhook
- Add webhook:
  - Payload URL: `http://(jenkins-server-ip):8080/github-webhook/`
  - SSL verification: Disable (for testing)
  - Add webhook

Jenkins:

- New Item
- Enter an item name: `(name)-(description))`, Freestyle project, OK
- Configure:
  - Description: `(Enter description)`
  - Discard old builds: tick
  - Strategy: Log Rotation
  - Max # of builds to keep: `3`
  - GitHub project: tick
  - Project url: `(HTTPS URL from GitHub repo, with trailing slash)`
  - Restrict where this project can be run: untick
  - Source Code Management: Git
  - Repository URL: `(SSL URL from GitHub repo)`
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

<!-- Jenkins config:
change branch to dev
Tick GitHub hook trigger for GITScm polling
make change to code -->
