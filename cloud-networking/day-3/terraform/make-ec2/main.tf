# Create an EC2 instance

# Provider block - What providers do we need to interact with?

# We will use AWS
provider "aws" {
    region = "eu-west-1"

    # Terraform will download all the required dependencies/plugins when you run "terraform init"
}

# Which service/resource
resource "aws_instance" "basic_instance" {
    # AMI ID
    ami = "ami-0e3f05635d98256de"

    # What instance type?
    instance_type = "t3.micro"

    # We want auto-assigned public IP
    associate_public_ip_address = true

    # Name instance on AWS
    tags = {
        Name = "se-matt-test-tf-instance"
    }
}