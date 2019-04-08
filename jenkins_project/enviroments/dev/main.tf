#declare module variables 
module "app" {
    source = "modules/app"    

    cidr_block = "${var.cidr_block}"
    subnet_id_public = "${var.subnet_id_public}"
    inet_gateway = "${var.inet_gateway}"
    instance = "${var.instance}"

}
