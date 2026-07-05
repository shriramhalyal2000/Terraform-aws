# define a vpc
resource "aws_vpc" "vpc_1"{
    cidr_block = var.vpc_cidr
    tags={
        Name = local.vpc_name
    }
}
# define a subnet

resource "aws_subnet" "subnet1"{
    vpc_id = aws_vpc.vpc_1.id
    cidr_block = var.subnet1_cidr
    map_public_ip_on_launch = true
    tags={
        Name = local.subnet1_name
    }
}
# define another subnet
resource "aws_subnet" "subnet2"{
    vpc_id = aws_vpc.vpc_1.id
    cidr_block = var.subnet2_cidr
    map_public_ip_on_launch = true
    tags={
        Name = local.subnet2_name
    }
}
#define an igw for vpc
resource "aws_internet_gateway" "vpc1_igw"{
    vpc_id = aws_vpc.vpc_1.id
}
# define a route table for both public subnet
resource "aws_route_table" "public_rt_1"{
    vpc_id = aws_vpc.vpc_1.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.vpc1_igw.id
    }
    tags={
        Name = local.public_rt_1_name
    }
}
# associate both subnets to this route table
resource "aws_route_table_association" "subnet1_asc"{
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.public_rt_1.id
}
resource "aws_route_table_association" "subnet2_asc"{
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.public_rt_1.id
}