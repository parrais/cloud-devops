## User data

- Launch instances > Advanced details > User data
- Commands are run as root
- May need to `sleep` to ensure instance is fully up before running commands
- Can launch multiple at same time

## Launch Templates

![Autoscaling](autoscaling.png)

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

## Auto Scaling Groups

- Auto Scaling Groups > Create Auto Scaling Group
- Name: se-matt-app-asg
- Launch template: My LT
- Next
- Availability zones and subnets: default-subnet-eu-west-1a, default-subnet-eu-west-1b, default-subnet-eu-west-1c
- Next
- Load balancing: Attach to a new load balancer
- Load balancer type: Application Load Balancer
- Load balancer name: se-matt-node20-app-asg-lb
- Load balancer scheme: Internet-facing
- Listeners and routing, Default routing: Create a target group
- New target group name: se-matt-node20-app-asg-lb-tg
- Turn on Elastic Load Balancing health checks
- Next
- Group size, Desired capacity: 2 --> standard
- Scaling:
  - Min desired capacity: 2 --> absolute min e.g. in case of instances failing
  - Max desired capacity: 3
  - Automatic scaling: Target tracking scaling policy
  - Scaling policy name: se-matt-target-policy
- Next
- Next
- Tags:
  - Key: Name
  - Value: se-matt-app-asg

Remove in order:

- Delete LB
- Delete TG
- Delete ASG
