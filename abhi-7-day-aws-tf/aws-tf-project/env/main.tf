# define a vpc
resource "aws_vpc" "task_vpc" {
  cidr_block = var.vpc_block

  tags = {
    Name        = local.task_name
    Enviornment = local.task_enviornment
  }
}
# define a public subnet with cidr blcok
resource "aws_subnet" "my_public_sbn" {
  vpc_id     = aws_vpc.task_vpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.sbn1_az
  map_public_ip_on_launch = true

  tags = {
    Name = local.public_sbn_name
  }
}

# define a igw for the vpc public subnet
resource "aws_internet_gateway" "task_vpc_igw" {
  vpc_id = aws_vpc.task_vpc.id

  tags = {
    Nmae = local.igw_name
  }
} 

# define a route table for public subnet
resource "aws_route_table" "public_sbn_rt" {
  vpc_id = aws_vpc.task_vpc.id
  depends_on = [ aws_internet_gateway.task_vpc_igw ]

  route {
    # show public subnet cidr block where is igw through this rt
    cidr_block = "0.0.0.0/0" # show route to public internet access not subnet cidr
    gateway_id = aws_internet_gateway.task_vpc_igw.id

  }
  tags={
    Name = local.public_sbn_rt_name
  }
}

resource "aws_route_table_association" "vpc_task_rt_assoc"{
  subnet_id = aws_subnet.my_public_sbn.id
  route_table_id = aws_route_table.public_sbn_rt.id
}

# define another publc subnet named subnet2

resource "aws_subnet" "public_sbn_2"{
  vpc_id = aws_vpc.task_vpc.id
  cidr_block = var.public_sbn_2_cidr
  availability_zone = var.sbn2_az
  map_public_ip_on_launch = true #any instance launched in this have public ip mapped to it by default 

  tags={
    Name = local.public_sbn_2_name
  }
}

resource "aws_route_table" "public_sbn_2_rt"{
  vpc_id = aws_vpc.task_vpc.id

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.task_vpc_igw.id # single gateway per vpc, so both subnet share same igw

  }

  tags={
    Name = local.public_sbn_2_rt_name
  }
}
# every route table needs route{} and route table association 
resource "aws_route_table_association" "vpc_task_sbn_2_rt"{
  subnet_id = aws_subnet.public_sbn_2.id
  route_table_id = aws_route_table.public_sbn_2_rt.id 
}