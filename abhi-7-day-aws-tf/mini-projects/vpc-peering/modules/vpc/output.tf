output "vpc1_id"{
    value = aws_vpc.vpc1.id
}
output "subnet1_id"{
    value = aws_subnet.subnet1.id
}
output "rt1_id"{
    value = aws_route_table.rt1.id
}
output "igw1_id" {
    value = aws_internet_gateway.igw1.id
}
output "vpc2_id"{
    value = aws_vpc.vpc2.id
}
output "subnet2_id"{
    value = aws_subnet.subnet2.id
}
output "rt2_id"{
    value = aws_route_table.rt2.id
}
output "igw2_id" {
    value = aws_internet_gateway.igw2.id
}