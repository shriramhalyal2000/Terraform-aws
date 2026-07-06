# create two vpc in same / different regions
# but for difficulty make two vpc and its subnets in differnt regions
# vpc 1 resource
resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc1_cidr
  tags = {
    Name = local.vpc1_name
  }
}
# vpc 2 resource
resource "aws_vpc" "vpc2" {
  cidr_block = var.vpc2_cidr
  tags = {
    Name = local.vpc2_name
  }
}
# vpc1 subnet resource
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.subnet1_cidr
  tags = {
    Name = local.subnet1_name
  }
}
# vpc2 subnet resource
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.vpc2.id
  cidr_block = var.subnet2_cidr
  tags = {
    Name = local.subnet2_name
  }
}
# vpc1 igw resource
resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = local.igw1_name
  }
}
# vpc 1 route tableresource 
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc1.id
  route {
    gateway_id = aws_internet_gateway.igw1.id
    cidr_block = "0.0.0.0/0"

  }
  tags = {
    Name = local.rt1_name
  }
}
resource "aws_route_table_association" "sbn1" {
  route_table_id = aws_route_table.rt1.id
  subnet_id      = aws_subnet.subnet1.id
}
# vpc2 igw resource
resource "aws_internet_gateway" "igw2" {
  vpc_id = aws_vpc.vpc2.id
  tags = {
    Name = local.igw2_name
  }
}
# vpc 2 subnet route table resource
resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.vpc2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw2.id
  }
  tags = {
    Name = local.rt2_name
  }
}
#vpc2 subnet assc resource
resource "aws_route_table_association" "sbn2" {
  route_table_id = aws_route_table.rt2.id
  subnet_id      = aws_subnet.subnet2.id
}