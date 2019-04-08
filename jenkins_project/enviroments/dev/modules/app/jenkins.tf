resource "aws_instance" "co_jenkins_master" {
    ami = "ami-0e12cbde3e77cbb98"
    subnet_id = "${aws_subnet.subnet_public.id}"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    key_name  = "${aws_key_pair.sshkey.key_name}" 
    

    tags {
        Name = "co_jenkins_master"
    }


  user_data = <<-EOF
   #!/bin/bash
    sudo yum remove java-1.6.0-openjdk.x86_64
   EOF
}

resource "aws_instance" "co_jenkins_slave" {
    ami = "ami-0e12cbde3e77cbb98"
    subnet_id = "${aws_subnet.subnet_public.id}"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    key_name  = "${aws_key_pair.sshkey.key_name}" 
    

    tags {
        Name = "co_jenkins_slave"
    }


  user_data = <<-EOF
   #!/bin/bash
   sudo apt rm 
   sudo apt install /etc/jenkins/jenkins-2.164.1-1.1.noarch.rpm
   EOF
}