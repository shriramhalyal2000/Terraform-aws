resource "aws_vpc" "poc"{
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags={
        Name = local.vpc_name
        Enviornment = local.Enviornment
    }
}
resource "aws_subnet" "poc_subnet"{
    depends_on = [ aws_vpc.poc ]
    vpc_id = aws_vpc.poc.id
    cidr_block = var.subnet_cidr
    availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true
    

    tags = {
        Name = local.sbn_name
    }
}

resource "aws_route_table" "poc_subnet"{
    vpc_id = aws_vpc.poc.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.poc_igw.id

    }

    tags={
        Name = local.rt_name
    }
}
resource "aws_internet_gateway" "poc_igw"{
    vpc_id = aws_vpc.poc.id

    tags = {
        Name = local.igw_name
    }
}

resource "aws_route_table_association" "poc_rt"{
    subnet_id = aws_subnet.poc_subnet.id
    route_table_id = aws_route_table.poc_subnet.id
}