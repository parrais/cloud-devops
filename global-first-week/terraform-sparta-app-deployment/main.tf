# Create an ec2 instance

## Provider block
provider "aws" {
  region = "eu-west-1"
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
  ami = "ami-0e3f05635d98256de"

  ## What type of instance?
  instance_type = "t3.micro"

  ## Please give me a public IP
  associate_public_ip_address = true

  # Add sg
  vpc_security_group_ids = [aws_security_group.sparta_app_sg.id]

  # run user data script
  user_data = file("./app-deploy.sh")

  ## Name of resource
  tags = {
    Name = "tech518-matt-sparta-app"
  }
}