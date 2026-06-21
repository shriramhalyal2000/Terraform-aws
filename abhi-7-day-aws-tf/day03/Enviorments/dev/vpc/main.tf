resource "aws_vpc" "my_task_1"{
    cidr_block = var.cidr_block

    tags={
        Name = local.vpc_name
        Enviornment = local.vpc_enviornment
    }
}

resource "aws_internet_gateway" "my_task_1_igw"{
    vpc_id = aws_vpc.my_task_1.id

    tags={
        Name = local.vpc_name
    }
}

# create aws_route table 
# create route table association

resource "aws_route_table" "my_task_1_rt"{
    vpc_id = aws_vpc.my_task_1.id

    route = ["0.0.0.0/0"] # string []

    tags={
        Name = local.vpc_name
    }
}