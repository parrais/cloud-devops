# create an ec2 instance

# where to create - provide cloud name
provider "aws" {

  # which region to use to create a resource/service
  region = var.aws_region

  # terraform will download all the required dependencies/plugins when you do
  # terraform init
}

# which service/resource
resource "aws_instance" "ec2_instances" {

  # which AMI ID 
  ami = var.ami_id

  # what type of instance to launch
  instance_type = var.ec2_instance_type

  # key pair
  key_name = var.ssh_key_pair

  # please add a public ip to this instance
  associate_public_ip_address = var.public_ip_check

  # Add sg
  vpc_security_group_ids = var.sg_ids

  # run user data script
  user_data = var.user_data_script

  # name the service
  tags = {
    Name = var.instance_name
  }
}