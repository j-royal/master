variable "instance_type" {
  type        = string
  description = "Instance Type"

}

variable "instance_name" {
  type        = string
  description = "Name of the EC2 Instance"

}

variable "subnet_cidr" {
  type        = string
  description = "Name of VPC"

}

variable "sg_name" {
  type = string
  
}