# Key Topics

## User data

When you launch an Amazon EC2 instance, you can pass user data to the instance that is used to perform automated configuration tasks, or to run scripts after the instance starts.

You can specify user data when you launch an instance with the Launch Wizard in the EC2 console. The User data field is located in the Advanced details section of the launch instance wizard. Enter a script (e.g. Bash) in the User data field, and then complete the instance launch procedure.

## Ports

A communication endpoint for network traffic. Numbered from 0 to 65535.

### Notable ports:

| Number   | Service                                                       |
| -------- | ------------------------------------------------------------- |
| 22       | Secure Shell (SSH) Secure Login                               |
| 80, 8080 | Hypertext Transfer Protocol (HTTP) used in the World Wide Web |
| 443      | HTTP Secure (HTTPS) HTTP over TLS/SSL                         |
| 27017    | MongoDB daemon process (mongod) and routing service (mongos)  |

## Monolith architecture

Monolithic architecture is a traditional software development model in which a single codebase executes multiple business functions. In a monolithic OS, the kernel directs all functionality. Monolithic architecture is often compared with microservices, which perform similar services but employ a different architecture.

## HTTP vs HTTPS

HTTPS is HTTP with encryption and verification. The only difference between the two protocols is that HTTPS uses TLS (SSL) to encrypt normal HTTP requests and responses, and to digitally sign those requests and responses. As a result, HTTPS is far more secure than HTTP. A website that uses HTTP has http:// in its URL, while a website that uses HTTPS has https://.

HTTP is simple to configure (e.g for our learning demos) as it does not require a certificate like HTTPS.

## SCP and RSYNC

Both can be used to copy files.

`scp` reads the source file and writes it to the destination. It performs a plain linear copy, locally, or over a network.

```
scp -i ~/.ssh/se-luke-key-pair.pem "nodejs20-se-test-app-2025.zip" ubuntu@34.244.245.244:~
```

`rsync` also copies files locally or over a network. But it employs a special delta transfer algorithm and a few optimizations to make the operation a lot faster. It can also resume aborted transfers so is useful for unreliable connections.

```
rsync A host:B
```

## NodeJS

JavaScript runtime that the Sparta App is written in.

## SSH Key pairs

Used to connect via SSH to EC2 instance.

Create at EC2 > Key pairs > Create key pair

- Set name, RSA, .pem
- Move .pem file to ~/.ssh
- `chmod 400 ~/.ssh/se-matt-key-pair.pem`

Add public key in EC2 'Launch instances' and connect via

```
ssh -i ~/.ssh/se-matt-key-pair.pem ubuntu@(hostname)
```

## BASH and Linux

Linux is an open source OS commonly used for servers due to its efficiency and reliability; Ubuntu is a well-known distribution.

## AMIs

An Amazon Machine Image (AMI) is an image that provides the software that is required to set up and boot an Amazon EC2 instance.

Create an image from an existing EC2 instance, to be used to create further identical instances:

- Actions > Image and templates > Create image

## Security groups

When you create a VPC, it comes with a default security group. You can create additional security groups for a VPC, each with their own inbound and outbound rules. You can specify the source, port range, and protocol for each inbound rule. You can specify the destination, port range, and protocol for each outbound rule.

## IP Addresses

- **Public vs Private IP addresses**
  - A Private IP Address is used for communication within a local network (LAN). It allows devices to send and receive data internally. Private IPs are not visible on the internet, making them more secure than public IPs.
  - A Public IP Address of a system is the IP address that is used to communicate outside the network.
- **CIDR blocks**
  - **[Classless Inter-Domain Routing](https://aws.amazon.com/what-is/cidr/)** is an IP address allocation method. 'Slash notation' includes an address in the network, followed by a slash, then the 'network prefix' which is the number of bits (out of 32 total available) outside the network.

## /posts page of Sparta App

Loads data from MongoDB database linked to the application.

## BASH Scripting

Bash scripts are text files that are named in the `.sh` format, start `#!/bin/bash`, and include a list of commands that are executed in order.

Add Bash scripts to AWS EC2 user data to be executed on instance launch.

`sleep` can be used to pause execution.

## pm2

PM2 is a process manager for the JavaScript runtime Node.js.

`pm2 start app.js`

`pm2 kill`

## Nginx

Nginx is a web server that can also be used as a reverse proxy or load balancer.

## environment variables

Often held in `~/.bashrc`, environment variables can be set with commands:

```
export DB_HOST=mongodb://10.0.3.241:27017/posts
```

and then checked with `printenv DB_HOST` and used by applications.

## systemctl commands

Command to control installed applications on a server.

- `sudo systemctl start (service)` - start a service
- `sudo systemctl status (service)` - check status of service
- `sudo systemctl restart (service)` - restart service
- `sudo systemctl enable (service)` - sets service to auto-start on system restart
