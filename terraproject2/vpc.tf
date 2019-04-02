#Create aws_vpc - CO_VPC
resource "aws_vpc" "CO_VPC" {
cidr_block = "${var.cidr_block}"
tags = {
    Name = "CO_VPC"
  }
}
# Create subnet Public
resource "aws_subnet" "subnet_public" {
  vpc_id     = "${aws_vpc.CO_VPC.id}"
  cidr_block = "${var.subnet_id_public}"
  tags = {
    Name = "CO_Subnet_Public"
  }
}
# Creating aws_internet_gateway - CO_igw
resource "aws_internet_gateway" "CO_igw" {
  vpc_id = "${aws_vpc.CO_VPC.id}"
  tags {
    Name = "CO_VPC - Internet Gateway"
  }
}
# Create CO_PUBLIC_RT - Defining route out from all (0.0.0.0/0) to aws_internet_gateway
resource "aws_route_table" "CO_Public_RT" {
    vpc_id = "${aws_vpc.CO_VPC.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.CO_igw.id}"
    }

    tags {
        Name = "CO_Public_RT"
    }
}
# Associte CO_Public_RT with Subnet_Public

resource "aws_route_table_association" "CO_VPC_ROUTE1" {
   subnet_id = "${aws_subnet.subnet_public.id}"
   route_table_id = "${aws_route_table.CO_Public_RT.id}"
}

# Create security group with web and ssh access
resource "aws_security_group" "co_web_server" {
  name = "co_web_server"
  vpc_id      = "${aws_vpc.CO_VPC.id}"

 ingress {
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
   egress {
   from_port       = 0
   to_port         = 0
   protocol        = "-1"
   cidr_blocks     = ["0.0.0.0/0"]
 }
} 
resource "aws_key_pair" "sshkey" {
 key_name   = "sshkey"
 public_key = "${file("~/.ssh/id_rsa.pub")}"
}

# Create web server
resource "aws_instance" "co_web_server" {
    ami = "ami-07dc734dc14746eab"
    vpc_security_group_ids = ["${aws_security_group.co_web_server.id}"]
    subnet_id = "${aws_subnet.subnet_public.id}"
    key_name  = "${aws_key_pair.sshkey.key_name}" 
    instance_type = "t2.micro"
    associate_public_ip_address = true
      
    tags {
        Name = "co_web-server"
    }

    user_data = <<-EOF
     #!/bin/bash
      sudo apt-get update
      sudo apt-get install apache2 -y
      sudo systemctl enable apache2
      sudo systemctl start apache2
      EOF 
    }



  
   



