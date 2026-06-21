locals{
    vpc_name = "task_vpc"
    vpc_enviornment = "task_enviornment"
    subnet_name = "public_subnet"
    subnet_name_private = "private_subnet"
    private_sbn_rt = aws_subnet.private_subnet.id
}