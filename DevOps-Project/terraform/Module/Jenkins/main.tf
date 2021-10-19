resource "aws_instance" "jenkins_server" {

  ami           = "ami-02f5781cba46a5e8a"
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.selected.id
  vpc_security_group_ids = [aws_security_group.Jenkins-SG.id]
  user_data = file("/Module/Jenkins/jenkins-install.sh")

  tags = {
    "Name" = "Jenkins"
  }
}

resource "aws_security_group" "Jenkins-SG" {
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
}

data "aws_subnet" "selected" {
  cidr_block = var.subnet_cidr
}
data "aws_vpc" "my_vpc" {

    cidr_block = var.vpc_cidr
  
}