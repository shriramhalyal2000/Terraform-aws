output "vpc_cidr"{
    value = aws_vpc.eks.cidr_block
}
output "vpc_region"{
    value = aws_vpc.eks.region
}
output "subnet1_cidr"{
    value = aws_subnet.eks_sub1.cidr_block
}
output "subnet2_cidr"{
    value = aws_subnet.eks_sub2.cidr_block
}
output "subnet1_az"{
    value = aws_subnet.eks_sub1.availability_zone
}
output "subnet2_az"{
    value = aws_subnet.eks_sub2.availability_zone
}
output "private_rt"{
    value = aws_route_table.eks_pvt_rt.id
}
output "igw_id"{
    value = aws_internet_gateway.eks_igw
}
output "public_sbn_cidr"{
    value = aws_subnet.eks_public_subnet.cidr_block
}
output "public_subnet_az"{
    value = aws_subnet.eks_public_subnet.availability_zone
}
output "natgtw"{
    value = aws_nat_gateway.eks_gtw.id
}