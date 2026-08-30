output "vpc_cidr"{
    value = module.eks.vpc_cidr
}
output "vpc_region"{
    value = module.eks.vpc_region
}
output "subnet1_cidr"{
    value = module.eks.subnet1_cidr
}
output "subnet1_az"{
    value = module.eks.subnet1_az
}
output "subent2_cidr"{
    value = module.eks.subnet2_cidr
}
output "subnet2_az"{
    value = module.eks.subnet2_az
}
output "default_rt"{
    value = module.eks.deafult_rt
}
output "igw_id"{
    value = module.eks.igw_id
}
output "public_cidr"{
    value = module.eks.public_sbn_cidr
}
output "publilc_az"{
    value = module.eks.public_subnet_az
}