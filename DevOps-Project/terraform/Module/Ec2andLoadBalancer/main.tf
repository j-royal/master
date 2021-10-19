terraform {
  required_version = ">= 1.0.3"
}
resource "aws_instance" "webserver" {

  ami           = "ami-0194c3e07668a7e36"
  instance_type = var.instance_type
  subnet_id = data.aws_subnet.selected.id
  vpc_security_group_ids = [ data.aws_security_group.web-sg.id ]

  tags = {
    "Name" = var.instance_name
  }
}

data "aws_subnet" "selected" {
  cidr_block = var.subnet_cidr
}

data "aws_security_group" "web-sg" {
  filter {
    name = "tag:Name"
    values = [var.sg_name]
  }
}
