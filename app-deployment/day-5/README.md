## User data

Add commands to run on EC2 instance creation.

- Launch instances > Advanced details > User data
- Commands are run as root
- May need to `sleep` to ensure instance is fully up before running commands
- Can launch multiple at same time

## Launch Templates

Add launch script to image; necessary for auto scaling.

- Create AMI
- Launch Templates > Create launch template
- Name: se-matt-asg-app-lt
- AMI: My app image
- Instance type: t3.micro
- Key pair: My pair
- Security group: My SG
- Advanced details > User data: Add script
- (Save)
- Launch instance from template > Launch instance
