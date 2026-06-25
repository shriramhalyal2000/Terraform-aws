variable "vpc_block" {
  description = "vpc default cir block"
  type        = string
}

variable "public_subnet_cidr" {
  description = "public subnet operation cidr block"
  type        = string
}
variable "public_sbn_2_cidr" {
  description = "public subnet 2 cidr"
  type = string
}
variable "sbn1_az" {
  description = "availability zone of subnet"
  type = string
}
variable "sbn2_az"{
  description = "availability zone of sbnet2"
  type = string
}