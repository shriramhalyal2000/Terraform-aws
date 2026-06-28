output "subnet_id" {
  value = module.vpc.subnet_id
}
output "vpc_id" {
  value = module.vpc.vpc_id
}
output "igw_id" {
  value = module.vpc.igw_id
}
output "subnet_2_id" {
  value = module.vpc.subnet_2_id
}
output "sbn1_az" {
  value = module.vpc.subnet1_az
}
output "sbn1_az_id" {
  value = module.vpc.subnet1_az_id
}
output "ipmap_sbn1" {
  value = module.vpc.subnet1_public_ip_maps
}
output "sbn2_az" {
  value = module.vpc.subnet2_az
}
output "sbn2_az_id" {
  value = module.vpc.subnet2_az_id
}
output "ipmap_sbn2" {
  value = module.vpc.subnet2_public_ip_maps
}
output "instance1_public_ip" {
  value = module.vpc.instance1_ip_map
}
output "instance1_profile" {
  value = module.vpc.instance1_profile
}
output "instance1_sbn_id" {
  value = module.vpc.instance1_subnet_id
}
output "instance1_id" {
  value = module.vpc.instance1_id
}
output "instance1_sg_id" {
  value = module.vpc.instance1_id
}
output "instance2_id" {
  value = module.vpc.instance2_id
}
output "instance2_profile" {
  value = module.vpc.instance2_profile
}
output "instance2_sbn_id" {
  value = module.vpc.instance2_subnet_id
}
output "instance2_sg" {
  value = module.vpc.instance2_sg
}
output "bucket_id" {
  value = module.vpc.bucket_id
}
output "loadbalancer_dns" {
  value = module.vpc.loadbalancer_dns
}