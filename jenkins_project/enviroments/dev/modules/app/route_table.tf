# Create CO_PUBLIC_RT - Defining route out from all (0.0.0.0/0) to aws_internet_gateway
resource "aws_route_table" "Public_RT" {
    vpc_id = "${aws_vpc.CO_VPC.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.CO_igw.id}"
    }

    tags {
        Name = "COPublic_RT"
    }
}