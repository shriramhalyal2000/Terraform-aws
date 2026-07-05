output "vpc_id"{
    value = module.vpc.vpc_id
}
output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}
output "subnet1_id"{
    value = module.vpc.subnet1_id
}
output "subnet1_cidr"{
    value = module.vpc.subnet1_cdir
}
output "subnet2_id"{
    value = module.vpc.subnet2_id
}
output "subnet2_cidr"{
    value = module.vpc.subnet2_cdir
}
output "rt_route"{
    value = module.vpc.route_table_route
}
output "root_instance_ids" {
  description = "Map of all EC2 instance IDs keyed by their environment/name"
  value       = module.ec2.instance_id
}

output "root_instance_public_ips" {
  description = "Map of all EC2 public IPs keyed by their environment/name"
  value       = module.ec2.instance_public_ip
}

output "root_instance_subnets" {
  description = "Map of all EC2 subnet IDs keyed by their environment/name"
  value       = module.ec2.instance_public_subnet
}