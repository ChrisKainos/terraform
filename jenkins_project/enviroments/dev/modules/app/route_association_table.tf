# Associte CO_Public_RT with Subnet_Public
resource "aws_route_table_association" "CO_VPC_ROUTE1" {
   subnet_id = "${aws_subnet.subnet_public.id}"
#   subnet_id = "${var.subnet_id_public}"
   route_table_id = "${aws_route_table.Public_RT.id}"
}
