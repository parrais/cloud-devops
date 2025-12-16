# Terraform

## Full automated app deployment

### `deploy-full-app`

Running this in Terraform will:

- Create an AWS VPC
- Create public and private subnets
- Create an internet gateway
- Create a route table
- Use the route table to link the gateway and subnets
- Create security groups for the application and database instances
- Create a MongoDB EC2 instance
- Create an application EC2 instance and link to the database

The `main.tf` file holds the application instance user data script, rather than reading an external `.sh` file.

A `variables.tf` file is required in the following format:

```
variable "aws_region" {
  type        = string
  description = "AWS region for app or db deployment"
  default     = "(desired AWS region)"
}

variable "vpc_name" {
  type        = string
  description = "Name of the created vpc"
  default     = "(name of VPC)"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the vpc"
  default     = "(CIDR-formatted IP range)"
}

variable "public_subnet_name" {
  type        = string
  description = "Name of the public subnet"
  default     = "(name of public subnet)"
}

variable "private_subnet_name" {
  type        = string
  description = "Name of the private subnet"
  default     = "(name of private subnet)"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet"
  default     = "(CIDR-formatted IP range)"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for the private subnet"
  default     = "(CIDR-formatted IP range)"
}

variable "public_subnet_az" {
  type        = string
  description = "Availability zone for the public subnet"
  default     = "(desired AWS AZ)"
}

variable "private_subnet_az" {
  type        = string
  description = "Availability zone for the private subnet"
  default     = "e(desired AWS AZ)"
}

variable "gateway_name" {
  type        = string
  description = "Name of the internet gateway"
  default     = "(name of gateway)"
}

variable "route_table_name" {
  type        = string
  description = "Name of the route table"
  default     = "(name of route table)"
}

variable "nodejs20_app_sg_name" {
  type        = string
  description = "Name of the app security group"
  default     = "(name of public subnet security group)"
}

variable "db_sg_name" {
  type        = string
  description = "Name of the database security group"
  default     = "(name of private subnet security group)"
}

variable "db_port" {
  type        = string
  description = "Port used by database"
  default     = "(DB port number)"
}

variable "app_ami_id" {
  type        = string
  description = "AMI for nodejs20 app instance"
  default     = "(AMI ID)"
}

variable "db_ami_id" {
  type        = string
  description = "AMI for mongodb instance"
  default     = "(AMI ID)"
}

variable "app_instance_type" {
  type        = string
  description = "EC2 instance type for app deployment"
  default     = "(instance type e.g. t3.micro)"
}

variable "db_instance_type" {
  type        = string
  description = "EC2 instance type for db deployment"
  default     = "(instance type e.g. t3.micro)"
}

variable "ssh_key_pair" {
  type        = string
  description = "SSH key pair for app or db EC2 instance"
  default     = "(name of key pair)"
}

variable "db_instance_name" {
  type        = string
  description = "Name of the created database instance"
  default     = "(DB instance name)"
}

variable "nodejs20_app_instance_name" {
  type        = string
  description = "Name of the created node.js 20 app instance"
  default     = "(app instance name)"
}
```
