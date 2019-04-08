resource "aws_internet_gateway" "CO_igw" {
  vpc_id = "${aws_vpc.CO_VPC.id}"
  tags {
    Name = "CO_VPC - Internet Gateway"
  }
}