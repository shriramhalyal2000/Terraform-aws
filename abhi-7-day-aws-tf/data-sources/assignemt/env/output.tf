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
output "instance_id"{
    value = module.ec2.instance_id
}
output "instance_dns"{
    value = module.ec2.instance_dns
}
output "instance_public_ip"{
    value = module.ec2.instance_public_ip
}
output "instance_sg_id"{
    value = module.ec2.instance_sg_id
}
output "instance_ebs_vol" {
  value = module.ec2.instance_ebs_vol
}
output "instance_key"{
    value = module.ec2.instance_key
}