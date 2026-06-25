# define a vpc
resource "aws_vpc" "task_vpc" {
  region     = var.task_region
  cidr_block = var.vpc_block

  tags = {
    Name        = local.task_name
    Enviornment = local.task_enviornment
  }
}
# define a public subnet with cidr blcok
resource "aws_subent" "my_public_sbn" {
  vpc_id     = aws_vpc.task_vpc.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = local.public_sbn_name
  }
}
# define a route table for public subnet
resource "aws_route_table" "public_sbn_rt" {
  vpc_id = aws_vpc.task_vpc.id

  route {
    # show public subnet cidr block where is igw through this rt
    cidr_block = var.public_subnet_cidr
    gateway_id = aws_internet_gateway.task_vpc_igw.id

  }
}
# define a igw for the vpc public subnet
resource "aws_internet_gateway" "task_vpc_igw" {
  vpc_id = aws_vpc.task_vpc.id

  tags = {
    Nmae = local.igw_name
  }
} 