# Auto Scaling Group Creation

## Prerequisites:

Instance -> AMI -> Launch template

## ASG creation steps

1. Go to Auto Scaling Groups

2. Click button Create an Auto Scaling group

3. On screen 1 Choose launch template or configuration:

   - Name: e.g. se-matt-app-asg
   - Select the launch template: filter by my name then select
   - At the bottom, click the Next button

4. On screen 2 Choose instance launch options:

   - In the Instance type requirements section:
     - leave it as is
   - In the Network section:
     - VPC: leave as the default-vpc
     - Availability zones and subnets: put a check mark next to the 3 different availability zones in the Ireland region:
       - default-subnet-eu-west-1a
       - default-subnet-eu-west-1b
       - default-subnet-eu-west-1c
   - At the bottom, click the Next button

5. On screen 3 Integrate with other services:

   - In the Load balancing section:
     - Select Attach to a new load balancer
     - In the Attach to a new load balancer section:
       - Load balancer type: select Application Load Balancer
       - Load balancer name: give it an appropriate name e.g. se-matt-app-asg-lb
       - Load balancer scheme: select Internet-facing
     - In Listeners and routing:
       - Protocol: notice the load balancer will be listening for HTTP
       - Port: leave as 80
       - Default routing:
         - For HTTP routing, select Create a target group
         - New target group name: add tg (tg=target group) to what's already there, so something like se-matt-app-asg-lb-tg
   - In VPC Lattice integration options section - leave it as is
   - In Health checks section:
     - Tick Turn on Elastic Load Balancing health checks
     - Health check grace period: leave it as 300 seconds
   - At the bottom, click the Next button

6. On screen 4 Configure group size and scaling policies:

   - In Group size - optional section:
   - Desired capacity: change to 2 _(standard)_
   - In Scaling:
   - Minimum capacity: change to 2 _(absolute min)_
   - Maximum capacity: change to 3
   - In Automatic scaling - optional section:
     - Select option Target tracking scaling policy
     - Scaling policy name: se-matt-target-policy
     - Metric type: leave it as Average CPU utilization
     - Target value: leave it as 50 (meaning 50%)
   - At the bottom, click the Next button

7. On screen 5 Add notifications:

   - Leave it as it is
   - At the bottom, click the Next button

8. On screen 6 Add tags:

   - Click Add tag button:
     - Key: Name
     - Value: se-matt-app-asg ❗ Important! If you don't add this tag, the instances created by the ASG will not be named!
   - At the bottom, click the Next button

9. On screen 7 Review:

   - Check over the details
   - At the bottom, click the Create Auto Scaling group button

10. Check Auto Scaling Group is working
    - Access the app via the Load Balancer:
      - Go to Load Balancers
      - Filter for your load balancer
      - Click on it to go to its Details
      - Copy the DNS name and paste it into a browser tab
      - Check the app frontpage works (and posts page if connected to database)

## Disposal

- Delete load balancer
- Delete target group
- Delete auto scaling group
