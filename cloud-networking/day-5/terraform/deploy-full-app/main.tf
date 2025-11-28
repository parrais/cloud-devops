provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.public_subnet_az

  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_subnet_az

  tags = {
    Name = var.private_subnet_name
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.gateway_name
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "app_server_sg" {
  name        = var.nodejs20_app_sg_name
  description = "Allow HTTP and SSH to app server"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH Ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_server_sg" {
  name        = var.db_sg_name
  description = "Allow DB and SSH to db server"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH Ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "DB ingress"
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = [var.public_subnet_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_mongodb_instance" {

  # which AMI ID 
  ami = var.db_ami_id

  # what type of instance to launch
  instance_type = var.db_instance_type

  # key pair
  key_name = var.ssh_key_pair

  # please add a public ip to this instance
  associate_public_ip_address = false

  # Add subnet
  subnet_id = aws_subnet.private_subnet.id

  # Add sg
  vpc_security_group_ids = [aws_security_group.db_server_sg.id]

  # name the service
  tags = {
    Name = var.db_instance_name
  }
}
resource "aws_instance" "ec2_node20_app_instance" {
  depends_on = [aws_instance.ec2_mongodb_instance]
  # which AMI ID 
  ami = var.app_ami_id

  # what type of instance to launch
  instance_type = var.app_instance_type

  # key pair
  key_name = var.ssh_key_pair

  # please add a public ip to this instance
  associate_public_ip_address = true

  # Add subnet
  subnet_id = aws_subnet.public_subnet.id

  # Add sg
  vpc_security_group_ids = [aws_security_group.app_server_sg.id]

  # run user data script
  user_data = <<-EOF
        #!/bin/bash
        sleep 15
        cd /home/ubuntu
        cd se-sparta-test-app
        cd app
        export DB_HOST=mongodb://${aws_instance.ec2_mongodb_instance.private_ip}:${var.db_port}/posts
        sudo npm install
        node seeds/seed.js
        pm2 start app.js
        EOF

  # name the service
  tags = {
    Name = var.nodejs20_app_instance_name
  }

}