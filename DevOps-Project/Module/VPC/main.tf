resource "aws_vpc" "VPC" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    "Name" = var.environment_name
  }
}

resource "aws_subnet" "Subnet1" {
  vpc_id = aws_vpc.VPC.id
  cidr_block = var.subnet_cidr1
  tags = {
    "Name" = var.environment_name
    }
  
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "main"
  }
  
}

resource "aws_route_table" "internet-rt" {
  vpc_id = aws_vpc.VPC.id
  tags = {
     Name = "internet-rt"
   }
}

resource "aws_route" "internet-r" {
  route_table_id = aws_route_table.internet-rt.id
  gateway_id = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}
