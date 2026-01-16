# Create an ec2 instance

## Provider block
provider "aws" {
  region = var.aws_region
}

## Get default VPC
data "aws_vpc" "default_vpc" {
  default = true
}

## Security group with default VPC, only allowing HTTP inbound
resource "aws_security_group" "sparta_app_sg" {
  name        = "tech518-matt-sparta-app-sg"
  description = "Allow HTTP to app server"
  vpc_id      = data.aws_vpc.default_vpc.id

  ingress {
    description = "HTTP ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## What service?
resource "aws_instance" "sparta_app_instance" {
  ## What AMI?
  ami = var.ami_id

  ## What type of instance?
  instance_type = "t3.micro"

  ## Please give me a public IP
  associate_public_ip_address = var.public_ip_check

  # Add sg
  vpc_security_group_ids = [aws_security_group.sparta_app_sg.id]

  # run user data script
  user_data = file(var.user_data_script)

  ## Name of resource
  tags = {
    Name = var.instance_name
  }
}