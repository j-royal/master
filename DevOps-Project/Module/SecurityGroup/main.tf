resource "aws_security_group" "Web-SG" {
    name = var.security_group_name
    vpc_id = data.aws_vpc.my_vpc.id
    tags = {
        "Name" = var.security_group_name
  }

    dynamic "ingress" { 
        iterator = port
        for_each = var.ingress_rules
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
    dynamic "egress" {
        iterator = port
        for_each = var.egress_rules
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
  
}

data "aws_vpc" "my_vpc" {

    cidr_block = var.vpc_cidr
  
}