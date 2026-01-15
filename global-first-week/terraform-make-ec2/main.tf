# Create an ec2 instance

## Provider block
provider "aws" {
  region = "eu-west-1"
}

## What service?
resource "aws_instance" "first_instance" {
  ## What AMI?
  ami = "ami-049442a6cf8319180"

  ## What type of instance?
  instance_type = "t3.micro"

  ## Please give me a public IP
  associate_public_ip_address = true

  ## Name of resource
  tags = {
    Name = "tech518-matt-first-tf-instance"
  }
}

### syntax of hcl is {key = name}