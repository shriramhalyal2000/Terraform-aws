output "vpc_id"{
    value = aws_vpc.vpc_1.id
}
output "vpc_cidr"{
    value = aws_vpc.vpc_1.cidr_block
}
output "subnet1_id"{
    value = aws_subnet.subnet1.id
}
output "subnet1_cdir"{
    value = aws_subnet.subnet1.cidr_block
}
output "subnet2_id"{
    value = aws_subnet.subnet2.id
}
output "subnet2_cdir"{
    value = aws_subnet.subnet2.cidr_block
}
output "route_table_route"{
    value = aws_route_table.public_rt_1.route
}