# Linux

## Why learn Linux?

- fast-growing
- inexpensive
- flexible
- stable (compared to Windows: less restarts needed?)
- scales well to perform scientific, engineering, network server tasks
- becoming more viable for desktop/workstation use
- often used in DevOps
- be more employable

## What is Linux?

- A spinoff the Unix OS
- Unix used be used on large mainframes
- Linux can now be run on small computers (which are now more powerful than the mainframes used to be)
- made up of a kernel (core OS), plus many libraries and utilities that rely on the kernel
- there are many different distributions (each using a specific kernel with specific supporting software)

## What is Bash?

- Stands for Bourne Again Shell
- Unix was a text-based OS, very much command-driven, so Bash is just an improved version of the shell used before in Unix
- To understand how to use Linux, you must know the basics of command-line tools
- Shells is like software/interface that runs the commands (aka command-line interpreter just like in older versions of Windows you had MS-DOS)
- There are a range of shells, but the most common default shell is bash

## Commands I

- AWS/Azure VM Management
  - Start/launch instance: "start instance", "launch instance"
  - Connect to instance: "connect" button

- SSH and Key Management
  - Open terminal: (general instruction, not a specific command)
  - Change directory: `cd`, `cd .ssh`, `cd ..`, `cd ~` (tilde for home)
  - List files: `ls`
  - Show hidden files: `ls -a`
  - Show detailed list: `ls -l`, `ls -la`
  - Change file permissions: `chmod 400 [filename]` 17:03
  - SSH into VM: `ssh -i [keyfile] [user]@[host]` (with path variations)
  - Exit SSH session: `exit`

- Linux System Information
  - Show OS name: `uname`
  - Show detailed OS info: `uname -a`
  - Show current user: `whoami`
  - Show current directory: `pwd`
  - Show running processes: `ps`

- Shell Utilities
  - Show command history: `history`
  - Clear command history: `history -c`

- File Downloading
  - Download with curl: `curl [URL]` and `curl [URL] --output [filename]`
  - Download with wget: `wget [URL]` (and with output filename)

- Other
  - Use tab for autocompletion (instruction, not a command)
  - Use up arrow for command history navigation (instruction, not a command)

## Commands II

- `mv` (move/rename files)
- `ls` (list files and folders)
- `file` (identify file type)
- `cp` (copy files)
- `rm` (remove files)
- `mkdir` (make directories)
- `ls -l` (detailed list of files/folders)
- `rm -r` (remove directories recursively)
- `rm -d` (remove empty directories)
- `cd` (change directory)
- `touch` (create empty file)
- `nano` (edit files in text editor)
- `cat` (print file contents to screen)

## Commands III

- `cat` (print file contents)
- `head` (show top lines of a file)
- `tail` (show bottom lines of a file)
- `nl` (number lines in a file)
- `grep` (search for keywords in files)
- `ls` (list directory contents)
- `tree` (visualize directory structure)
- `apt` install [package] (install packages)
- `sudo` (run command as superuser)
- `sudo apt update` (update package sources)
- `sudo apt upgrade` (upgrade packages)
- `pwd` (print working directory)
- `cd` (change directory)
- `cd ..` (move to parent directory)
- `su` (switch user, used with sudo)
- `exit` (log out from superuser/root)
- `mv` (move/rename files)
- `mkdir` (make directory)
- `cp` (copy files)
- `rm -r` (remove directory recursively)
- `rm -rf` (remove directory recursively with force)

## Commands IV

- `sudo apt update`
- `sudo apt upgrade -y`
- `sudo apt install nginx -y`
- `systemctl status nginx`
- `systemctl is-enabled nginx`
- `sudo systemctl enable nginx`
- `sudo systemctl restart nginx`
- `systemctl stop nginx`
- `systemctl start nginx`
- `nano install_nginx.sh`
- `ls -l`
- `chmod +x install_nginx.sh`
- `./install_nginx.sh`
- `cat install_nginx.sh`

## Redirection and appending

- The `>` symbol is a redirection operator used to send the output of a command into a file e.g. `echo "Hello World" > greetings.txt`. It overwrites the existing content of the file.
- The append operator `>>` works almost the same way, but it adds new output to the end of a file without deleting what is already there e.g. `echo "Hello to you" >> greetings.txt` would add an extra line to `greetings.txt`.

## Piping

- The `|` symbol can be used to 'pipe' the output from one command to be used as input by another command.
- While redirection operators like `>` or `>>` send output to files, a pipe connects processes together.
- An example of a command that uses piping once:
  ```bash
  ls | grep "txt"
  ```
  (Shows a list of files with `txt` in the name in the current directory)
- Give an example of a command that uses piping twice:
  ```bash
  ls | grep "txt" | wc -l
  ```
  (Counts the number of files with `txt` in the name in the current directory)
- Give an example of a command that uses piping twice, than sends the output to a file:
  ```bash
  ps aux | grep "python" | grep -v "grep" > process_log.txt
  ```
  (Lists every program currently running, filters to only show lines containing `python`, filters out the line for `grep` itself, and outputs to `process_log.txt`)
