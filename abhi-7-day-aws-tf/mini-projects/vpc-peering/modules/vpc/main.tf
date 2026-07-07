# create two vpc in same / different regions
# but for difficulty make two vpc and its subnets in differnt regions
# vpc 1 resource
resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpc1_cidr
  provider             = aws.primary
  instance_tenancy     = var.instance_tenancy_vpc1
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = local.vpc1_name
  }
}
# vpc 2 resource
resource "aws_vpc" "vpc2" {
  cidr_block           = var.vpc2_cidr
  provider             = aws.secondary
  instance_tenancy     = var.instance_tenancy_vpc2
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = local.vpc2_name
  }
}
# vpc1 subnet resource
resource "aws_subnet" "subnet1" {
  depends_on = [ aws_vpc.vpc1 ]
  vpc_id                  = aws_vpc.vpc1.id
  provider = aws.primary
  cidr_block              = var.subnet1_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.vpc1sbn1.names[0]
  tags = {
    Name = local.subnet1_name
  }
}
# vpc2 subnet resource
resource "aws_subnet" "subnet2" {
  depends_on              = [aws_vpc.vpc2]
  provider                = aws.secondary
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = var.subnet2_cidr
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.vpc2sbn2.names[0]
  tags = {
    Name = local.subnet2_name
  }
}
# vpc1 igw resource
resource "aws_internet_gateway" "igw1" {
  depends_on = [ aws_vpc.vpc1 ]
  vpc_id = aws_vpc.vpc1.id
  provider = aws.primary
  tags = {
    Name = local.igw1_name
  }
}
# vpc 1 route tableresource 
resource "aws_route_table" "rt1" {
  depends_on = [ aws_vpc.vpc1, aws_subnet.subnet1 , aws_internet_gateway.igw1]
  provider = aws.primary
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
  depends_on = [ aws_vpc.vpc1, aws_subnet.subnet1, aws_route_table.rt1 ]
  provider = aws.primary
  route_table_id = aws_route_table.rt1.id
  subnet_id      = aws_subnet.subnet1.id
}
# vpc2 igw resource
resource "aws_internet_gateway" "igw2" {
  depends_on = [aws_vpc.vpc2]
  provider   = aws.secondary
  vpc_id     = aws_vpc.vpc2.id
  tags = {
    Name = local.igw2_name
  }
}
# vpc 2 subnet route table resource
resource "aws_route_table" "rt2" {
  depends_on = [aws_vpc.vpc2, aws_internet_gateway.igw2]
  provider   = aws.secondary
  vpc_id     = aws_vpc.vpc2.id
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
  depends_on     = [aws_subnet.subnet2, aws_route_table.rt2, aws_vpc.vpc1]
  provider       = aws.secondary
  route_table_id = aws_route_table.rt2.id
  subnet_id      = aws_subnet.subnet2.id
}
# create peering resource for both vpc
resource "aws_vpc_peering_connection" "requestor"{
  provider = aws.primary
  vpc_id = aws_vpc.vpc1.id # peering initiator id
  peer_vpc_id = aws_vpc.vpc2.id # destination vpc id
  peer_region = data.aws_region.secondary.name
  auto_accept = false

  tags={
    Name = local.peer_vpc1_conn
    Side = local.peering_con_side_1
  }
}
# create peering resource for both vpc by it being accptor for vpc1 per request
resource "aws_vpc_peering_connection_accepter" "acceptor"{
  provider = aws.secondary
  depends_on = [ aws_vpc_peering_connection.requestor ]
  vpc_peering_connection_id = aws_vpc_peering_connection.requestor.id
  auto_accept = true

  tags={
    Name = local.peer_vpc2_conn
    Side = local.peering_con_side_2
  }
}
# create route for vpc peering
resource "aws_route" "vpc1_to_vpc2"{
  provider = aws.primary
  depends_on = [ aws_vpc_peering_connection_accepter.acceptor ]
  route_table_id = aws_route_table.rt1.id
  destination_cidr_block = aws_vpc.vpc2.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.requestor.id
}
resource "aws_route" "vpc2_to_vpc1"{
  provider = aws.secondary
  depends_on = [ aws_vpc_peering_connection_accepter.acceptor ]
  route_table_id = aws_route_table.rt2.id
  destination_cidr_block = aws_vpc.vpc1.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.acceptor.id
}