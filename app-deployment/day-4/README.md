## Running scripts

Can run a script with

- `./script.sh` (needs permissions)
- `source script.sh`
- `bash script.sh`

## Images

Actions > Image and templates > Create image

(Once created)
Create instance
Name: se-matt-mongodb-from-image
AMI: se-matt-mongodb-image

## Monitoring

![Monitoring options](monitoring.png)

In EC2 instances:

- Actions > Monitor and troubleshoot > Manage detailed monitoring
- Tick 'Enable'

In CloudWatch:

- Dashboards > Create dashboard
- Cancel
- Add Widget, Line, Next
- Search by instance id
- Search by CPU
- EC2 Per-Instance Metrics > CPUUtilization
- Custom time frame (3 mins)
- Create widget
- Add widget for NetworkIn and NetworkOut
