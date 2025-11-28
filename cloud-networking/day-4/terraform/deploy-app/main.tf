# create an ec2 instance

# where to create - provide cloud name
provider "aws" {

    # which region to use to create a resource/service
    region = "eu-west-1"

    # terraform will download all the required dependencies/plugins when you do
    # terraform init
}

# which service/resource
resource "aws_instance" "app_instance" {
    
    # which AMI ID 
    ami = "ami-0e3f05635d98256de"

    # what type of instance to launch
    instance_type = "t3.micro"

    # key pair
    key_name = "se-matt-key-pair"

    # please add a public ip to this instance
    associate_public_ip_address = true
    
    # Add sg
    vpc_security_group_ids = ["sg-03237d018a567fc1d"]

    # run user data script
    user_data = file("./app-deploy.sh")

    # name the service
    tags = {
        Name = "se-matt-terraform-app"
    }
}