#Create aws_vpc - CO_VPC
resource "aws_vpc" "CO_VPC" {
cidr_block = "${var.cidr_block}"
tags = {
    Name = "CO_VPC"
  }
}