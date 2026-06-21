output "vpc_name"{
    value = module.vpc.vpc_name
}

output "vpc_id"{
    value = module.vpc.vpc_id
}
output "route_table_id_id"{
    value = module.vpc.rt_id
}
output "igw_id"{
    value = module.vpc.igw_id
}
output "priavet_sbn_cidr_id"{
    value = module.vpc.priavet_sbn_cidr_id.id
}