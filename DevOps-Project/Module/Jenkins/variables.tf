variable "subnet_cidr" {
    type = string
}

variable "ingress_rules" {
    type = list
    default = [80, 443, 8080, 8443]
  
}

variable "security_group_name" {
    type = string
}

variable "vpc_cidr" {
  type = string
}