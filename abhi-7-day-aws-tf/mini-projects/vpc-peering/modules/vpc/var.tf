variable "vpc1_cidr" {
  description = "vpc1 ip cidr"
  type        = string
}
variable "vpc2_cidr" {
  description = "vpc2 ip cidr"
  type        = string
}
variable "subnet1_cidr" {
  description = "subnet1 ip cidr in vpc1"
  type        = string
}
variable "subnet2_cidr" {
  description = "subnet2 ip cidr in vpc2"
  type = string
}
variable "instance_tenancy_vpc1"{
  description = "vpc1 instance tenancy "
  type = string
}
variable "instance_tenancy_vpc2"{
  description = "vpc2 instance tenancy "
  type = string
}