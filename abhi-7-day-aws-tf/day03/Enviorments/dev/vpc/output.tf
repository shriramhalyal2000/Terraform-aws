output "vpc_name"{
    value = aws_vpc.my_task_1.tags
}

output "vpc_id"{
    value = aws_vpc.my_task_1.id
}

output "igw_id"{
    value = aws_internet_gateway.my_task_1_igw.id
}

output "rt_id"{
    value = aws_route_table.my_task_1_rt.id
}