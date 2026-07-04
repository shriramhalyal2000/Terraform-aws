variable "vpc_cidr"{
    description = "vpc default cidr block"
    type = string
}
variable "subnet1_cidr"{
    description = "this is a cidr block of public subnet1"
    type = string
}
variable "subnet1_az"{
    description = "availability zone of public subnet1"
    type = string
}
variable "subnet2_cidr" {
  description = "public subnet 2 cidr block"
  type = string
}
variable "subnet2_az"{
    description = "pubic subnet 2 availability zone"
    type = string
}