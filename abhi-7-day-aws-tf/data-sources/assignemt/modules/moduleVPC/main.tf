# this fiel only has vpc networking components like vpc, subnet, igw and routetables
# define a vpc
resource "aws_vpc" "module_vpc"{
    cidr_block = var.vpc_cidr
    tags={
        Name = local.vpc_tag_name
        Enviornment = local.vpc_tag_enviornment
    }
}
# define a public subnet
resource "aws_subnet" "subnet1"{
    vpc_id = aws_vpc.module_vpc.id
    cidr_block = var.subnet1_cidr
    availability_zone = var.subnet1_az
    map_public_ip_on_launch = true
    tags= {
        Name = local.subnet1_name
    }
}
# define an igw
resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.module_vpc.id
    tags= {
        Name = local.aws_internet_gateway
    }
}
# define a route table
resource "aws_route_table" "route_table1"{
    vpc_id = aws_vpc.module_vpc.id
    
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}
resource "aws_route_table_association" "subnet_1"{
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.route_table1.id
}
# define subnet2 
resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.module_vpc.id
  cidr_block = var.subnet2_cidr
  availability_zone = var.subnet2_az
  map_public_ip_on_launch = true

  tags ={Name = local.subnet2_name}
}
# associating sunet 2 with route table
resource "aws_route_table_association" "subnet2"{
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.route_table1.id
}