output "vpc_id"{
    value = aws_vpc.poc.id
}
output "subnet_id"{
    value = aws_subnet.poc_subnet.id
}
output "aws_igw"{
    value = aws_internet_gateway.poc_igw.id
}
output "vpc_cidr"{
    value = aws_vpc.poc.cidr_block
}
output "subnet_az"{
    value = aws_subnet.poc_subnet.availability_zone
}
output "subnet_cidr"{
    value = aws_subnet.poc_subnet.cidr_block
}