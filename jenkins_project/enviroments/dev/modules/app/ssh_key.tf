resource "aws_key_pair" "sshkey" {
 key_name   = "sshkey"
 public_key = "${file("~/.ssh/id_rsa.pub")}"
}