# create a vpc
resource "aws_vpc" "my_task_1"{
    cidr_block = var.cidr_block_vpc #vpc cidr block

    tags={
        Name = local.vpc_name
        Enviornment = local.vpc_enviornment
    }
}

# define a private subnet

resource "aws_subnet" private_subnet{
    vpc_id = aws_vpc.my_task_1.id
    cidr_block = var.private_subnet_cidr

    tags={
        Name = local.subnet_name_private
    }
}

# define a public subnet
resource "aws_subnet" "public_subnet"{
    vpc_id  = aws_vpc.my_task_1.id
    cidr_block = var.public_subnet_cidr

    tags={
        Name = local.subnet_name
    }
}
# attach igw to vpc
resource "aws_internet_gateway" "my_task_1_igw"{
    vpc_id = aws_vpc.my_task_1.id

    tags={
        Name = local.vpc_name
    }
}

# define aws_route table 
# associate route table with igw

resource "aws_route_table" "my_task_1_rt"{
    vpc_id = aws_vpc.my_task_1.id
    route {
        cidr_block = var.cidr_block_rt
        gateway_id = aws_internet_gateway.my_task_1_igw.id
        }
    tags={
        Name = local.vpc_name
    }
}

# define route table association to subnet and rt

resource "aws_route_table_association" "my_task_1_rt-assoc"{
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.my_task_1_rt.id
}