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