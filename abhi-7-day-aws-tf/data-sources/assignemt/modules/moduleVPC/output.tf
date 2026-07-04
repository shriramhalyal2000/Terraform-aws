output "vpc_id"{
    value = aws_vpc.module_vpc.id
}
output "vpc_cidr"{
    value = aws_vpc.module_vpc.cidr_block
}
output "subnet1_id"{
    value = aws_subnet.subnet1.id
}
output "subnet1_cidr"{
    value = aws_subnet.subnet1.cidr_block
}
output "subnet1_az"{
    value = aws_subnet.subnet1.availability_zone_id
}
output "subnet2_id"{
    value = aws_subnet.subnet2.id
}
output "subnet2_cidr"{
    value = aws_subnet.subnet2.cidr_block
}
output "subnet2_az"{
    value = aws_subnet.subnet2.availability_zone_id
}
output "igw_id"{
    value = aws_internet_gateway.igw.id
}
output "igw_vpc_id"{
    value = aws_internet_gateway.igw.vpc_id
}
output "route_table_id"{
    value = aws_route_table.route_table1.id
}
output "route_table_route"{
    value = aws_route_table.route_table1.route
}