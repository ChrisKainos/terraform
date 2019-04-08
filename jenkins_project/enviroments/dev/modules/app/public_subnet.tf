# Create subnet Public
resource "aws_subnet" "subnet_public" {
  vpc_id     = "${aws_vpc.CO_VPC.id}"
  cidr_block = "${var.cidr_block}"
  tags = {
    Name = "CO_Subnet_Public"
  }
}
