resource "aws_network_interface_sg_attachment" "co_security_group" {
  security_group_id    = "${aws_security_group.co_security_group.id}"
  network_interface_id = "${aws_instance.co_jenkins_master.primary_network_interface_id}"
}

resource "aws_network_interface_sg_attachment" "co_security_group2" {
  security_group_id    = "${aws_security_group.co_security_group.id}"
  network_interface_id = "${aws_instance.co_jenkins_slave.primary_network_interface_id}"
}