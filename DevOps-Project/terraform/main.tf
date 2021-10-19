provider "aws" {
  region = var.region

}

module "Web_server" {
  source        = "./Module/Ec2andLoadBalancer"
  instance_type = "t2.micro"
  instance_name = "Dev Server"
  subnet_cidr   = "10.0.1.0/24"
  sg_name = "web-sg"

  depends_on = [
    module.Security_Group
  ]

}

module "VPC" {
  source = "./Module/VPC"
  vpc_cidr = "10.0.0.0/16"
  subnet_cidr1 = "10.0.1.0/24"
  environment_name = "Dev"

}

module "Security_Group" {
  source = "./Module/SecurityGroup"
  vpc_cidr = "10.0.0.0/16"
  security_group_name = "web-sg"

  depends_on = [
    module.VPC
  ]
  
}

module "Jenkins_Server" {
  source = "./Module/Jenkins"
  vpc_cidr = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
  security_group_name = "jenkins_sg"

  depends_on = [
    module.VPC
  ]
  
}