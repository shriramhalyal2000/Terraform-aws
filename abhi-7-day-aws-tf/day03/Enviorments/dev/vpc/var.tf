variable "cidr_block_vpc"{
    description = "cirdr block for vpc"
    type = string
}

variable "public_subnet_cidr"{
    description = "public subnet cidr block "
    type = string
}

variable "cidr_block_rt" {
    description = "route table showing path to subnet of igw"
    type = string
}

variable "private_subnet_cidr"{
    description = "private subnet with no access to internet"
    type = string
}