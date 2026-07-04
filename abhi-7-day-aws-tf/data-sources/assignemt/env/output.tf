output "vpc_id"{
    value = module.vpc.vpc_id
}
output "subnet1_id"{
    value = module.vpc.subnet1_id
}
output "subnet2_id"{
    value = module.vpc.subnet2_id
}
output "subnet1_az"{
    value = module.vpc.subnet1_az
}
output "subnet2_az"{
    value = module.vpc.subnet2_az
}
output "subnet1_cidr"{
    value = module.vpc.subnet1_cidr
}
output "subnet2_cidr"{
    value = module.vpc.subnet2_cidr
}