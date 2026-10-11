output "vpc_id"{
    value = module.vpc.vpc_id
}
output "vpc_cidr"{
    value = module.vpc.vpc_cidr
}
output "subnet_id"{
    value = module.vpc.subnet_id
}
output "subnet_cidr"{
    value = module.vpc.subnet_cidr
}
output "igw_id"{
    value = module.vpc.aws_igw
}