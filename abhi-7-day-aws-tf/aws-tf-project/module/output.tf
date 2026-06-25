output "subnet_id"{
    value = module.vpc.subnet_id
}
output "vpc_id"{
    value = module.vpc.vpc_id
}
output "igw_id"{
    value = module.vpc.igw_id
}
output "subnet_2_id"{
    value = module.vpc.subnet_2_id
}
output "sbn1_az"{
    value = module.vpc.subnet1_az
}
output "sbn1_az_id"{
    value = module.vpc.subnet1_az_id
}
output "ipmap_sbn1"{
    value = module.vpc.subnet1_public_ip_maps
}
output "sbn2_az"{
    value = module.vpc.subnet2_az
}
output "sbn2_az_id"{
    value = module.vpc.subnet2_az_id
}
output "ipmap_sbn2"{
    value = module.vpc.subnet2_public_ip_maps
}