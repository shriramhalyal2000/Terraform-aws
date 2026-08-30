# vpc definition for eks deployment

resource "aws_vpc" "eks"{
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"

    enable_dns_hostnames = true
    enable_dns_support = true

    tags={
        Name = local.vpc_name
    }
}

# creating two subnets for failover subent if nodes go offline in eks subnets.
# private subnet 1 for eks vpc
resource "aws_subnet" "eks_sub1"{
    # since it required vpc id it doesnot need depends on to add complexity
    vpc_id = aws_vpc.eks.id
    cidr_block = var.sub1_cidr
    availability_zone = data.aws_availability_zones.available.names[0]

    tags={
        Name = local.sub1_name
    }

}
# private subnet 2 for eks vpc
resource  "aws_subnet" "eks_sub2"{
    vpc_id = aws_vpc.eks.id
    cidr_block = var.sub2_cidr
    availability_zone = data.aws_availability_zones.available.names[1]

    tags={
        Name = local.sub2_name
    }
}
# internet gateway for eks vpc
resource "aws_internet_gateway" "eks_igw"{
    vpc_id = aws_vpc.eks.id

    tags={
        Name = local.igw_name
    }
}

resource "aws_route_table" "eks_pvt_rt"{
    vpc_id = aws_vpc.eks.id

    route{
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.eks_gtw.id
    }
    tags={
        Name = local.rt_name
    }
}

resource "aws_route_table_association" "eks_sbn1_asc" { # joining rt with subnet1
    subnet_id = aws_subnet.eks_sub1.id
    route_table_id = aws_route_table.eks_pvt_rt.id
}
resource "aws_route_table_association" "eks_sbn2_asc" { # joining rt with subnet2
    subnet_id = aws_subnet.eks_sub2.id
    route_table_id = aws_route_table.eks_pvt_rt.id
}
# defining a public subnet to house a nat gateway

resource "aws_subnet" "eks_public_subnet"{
    vpc_id = aws_vpc.eks.id
    cidr_block = var.eks_public_sbn_cidr
    availability_zone = data.aws_availability_zones.available.names[2]
    map_public_ip_on_launch = true

    tags={
        Name = local.eks_public_sbn_name
    }
}

resource "aws_route_table" "eks_pub_sbn_rt"{
    vpc_id = aws_vpc.eks.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.eks_igw.id
    }
    tags={
        Name = local.eks_public_rt
    }
}

resource "aws_route_table_association" "eks_public_sbn" {
    subnet_id = aws_subnet.eks_public_subnet.id
    route_table_id = aws_route_table.eks_pub_sbn_rt.id
}
# deploying eip for nat-gateway

resource "aws_eip" "eks_eip"{
    domain = "vpc"
    depends_on = [ aws_internet_gateway.eks_igw ]
}

resource "aws_nat_gateway" "eks_gtw"{
    allocation_id = aws_eip.eks_eip.id
    subnet_id = aws_subnet.eks_public_subnet.id

    tags={
        Name = local.nat_gtw
    }
    depends_on = [ aws_internet_gateway.eks_igw ]
}
