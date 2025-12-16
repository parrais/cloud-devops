# Terraform

## Deployment folders

The `.tf` files in each folder perform the following tasks:

### `deploy-app`

Deploys a standalone AWS EC2 application instance.

### `deploy-vpc`

This creates a new AWS VPC, public subnet, private subnet, internet gateway, and route table, linked together appropriately.

### `deploy-github-repo`

This creates a new GitHub repo, and requires a `variables.tf` file:

```
variable "github_token" {
  type        = string
  description = "GitHub personal access token"
  default     = "Insert a GitHub personal access token of the form 'github_pat_...' here"
}
```

### `deploy-app-or-db`

This deploys a basic EC2 instance and application, and requires a `variables.tf` file:

```
variable "aws_region" {
  type        = string
  description = "AWS region for app or db deployment"
  default     = "(desired AWS region)"
}

variable "ami_id" {
  type        = string
  description = "AMI for EC2 app instance"
  default     = "(AWS AMI ID)"
}

variable "ec2_instance_type" {
  type        = string
  description = "EC2 instance type for app or db deployment"
  default     = "(AWS instance type)"
}

variable "ssh_key_pair" {
  type        = string
  description = "SSH key pair for app or db EC2 instance"
  default     = "(SSH key pair name)"
}

variable "public_ip_check" {
  type        = bool
  description = "Create public IP for EC2 instance"
  default     = true
}

variable "sg_ids" {
  type        = list(string)
  description = "Security group for EC2 instance"
  default     = (["(AWS security group ID)"])
}

variable "instance_name" {
  type        = string
  description = "Name of the created instance"
  default     = "(desired instance name)"
}

variable "user_data_script" {
  type        = string
  description = "Script to be used in user data field"
  default     = "./(user script to apply).sh"
}
```

Terraform can be run with either `-var-file="db.tfvars"` or ` -var-file="app.tfvars"` to modify for application or database deployment, with these contents for the respective files:

```
ami_id = (app or db AMI ID)
public_ip_check = (true for app, false for db)
sg_ids = ["(security group ID)"]
instance_name = "(instance name)"
user_data_script = "(./(deploy script to apply - use blank file if not needed e.g. for db).sh)"
```
