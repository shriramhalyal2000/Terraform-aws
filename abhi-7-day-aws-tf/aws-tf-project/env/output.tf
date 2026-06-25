output "vpc_id"{
    value = aws_vpc.task_vpc.id
}
output "subnet_id"{
    value = aws_subnet.my_public_sbn.id
}
output "subnet_2_id" {
  value = aws_subnet.public_sbn_2.id
}
output "igw_id"{
    value = aws_internet_gateway.task_vpc_igw.id
}
output "subnet1_az"{
    value = aws_subnet.my_public_sbn.availability_zone
}
output  "subnet1_az_id"{
    value = aws_subnet.my_public_sbn.availability_zone_id
}
output "subnet2_az"{
    value = aws_subnet.public_sbn_2.availability_zone
}
output "subnet2_az_id"{
    value = aws_subnet.public_sbn_2.availability_zone_id
}
output "subnet1_public_ip_maps"{
    value = aws_subnet.my_public_sbn.map_public_ip_on_launch
}
output "subnet2_public_ip_maps"{
    value = aws_subnet.my_public_sbn.map_public_ip_on_launch
}