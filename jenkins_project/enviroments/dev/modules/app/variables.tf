# Declare enviroment variables
variable "cidr_block" {}
variable "subnet_id_public" {}
variable "inet_gateway" {}

variable "region" {
  default = "eu-west-1"
}

variable "instance" {}