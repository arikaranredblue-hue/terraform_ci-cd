resource "aws_instance" "my_ec2" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [var.sg_group]
    subnet_id = var.subnet_id
}