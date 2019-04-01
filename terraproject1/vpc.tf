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
#Create Subnet Private 
resource "aws_subnet" "subnet_private" {
  vpc_id     = "${aws_vpc.CO_VPC.id}"
  cidr_block = "${var.subnet_id_private}"
  tags = {
    Name = "CO_Subnet_Private"
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

#Create CO_Private_RT - Leaving routes blank to set no route from private table
resource "aws_route_table" "CO_Private_RT" {
    vpc_id = "${aws_vpc.CO_VPC.id}"


    tags {
        Name = "CO_Private_RT"
    }
}

# Associte CO_Private_RT with Subnet_private
resource "aws_route_table_association" "CO_VPC_ROUTE2" {
    subnet_id = "${aws_subnet.subnet_private.id}"
    route_table_id = "${aws_route_table.CO_Private_RT.id}"
}
