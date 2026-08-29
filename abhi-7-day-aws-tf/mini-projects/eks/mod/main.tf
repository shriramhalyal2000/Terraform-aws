# vpc definition for eks deployment

resource "aws_vpc" "eks"{
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"

    tags={
        Name = local.vpc_name
    }
}

# creating two subnets for failover subent if nodes go offline in eks subnets.

resource "aws_subnet" "eks_sub1"{
    # since it required vpc id it doesnot need depends on to add complexity
    vpc_id = aws_vpc.eks.id
    cidr_block = var.sub1_cidr
    availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true # should be true if any new nodes to be launched, if left on auto throttle.

    tags={
        Name = local.sub1_name
    }

}
resource  "aws_subnet" "eks_sub2"{
    vpc_id = aws_vpc.eks.id
    cidr_block = var.sub2_cidr
    availability_zone = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = true

    tags={
        Name = local.sub2_name
    }
}

resource "aws_internet_gateway" "eks_igw"{
    vpc_id = aws_vpc.eks.id

    tags={
        Name = local.igw_name
    }
}

resource "aws_default_route_table" "eks_rt"{
    default_route_table_id = aws_vpc.eks.default_route_table_id
    tags={
        Name = local.rt_name
    }
}

resource "aws_route_table_association" "eks_sbn1_asc" { # joining rt with subnet1
    subnet_id = aws_subnet.eks_sub1.id
    route_table_id = aws_default_route_table.eks_rt.id
}
resource "aws_route_table_association" "eks_sbn2_asc" { # joining rt with subnet2
    subnet_id = aws_subnet.eks_sub2.id
    route_table_id = aws_default_route_table.eks_rt.id
}