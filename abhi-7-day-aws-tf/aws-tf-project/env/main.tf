resource "aws_vpc" "task_vpc"{
    region = var.task_region
    cidr_block = var.vpc_block

    tags ={
        Name = local.task_name
        Enviornment = local.task_enviornment
    }
}

resource "aws_subent" "my_public_sbn"{
    vpc_id = aws_vpc.task_vpc.id
    cidr_block = var.public_subnet_cidr

    tags={
        Name = local.public_sbn_name
    }
}

resource "aws_route_table" "public_sbn_rt"{
    vpc_id = aws_vpc.task_vpc.id

    route{
    }
}