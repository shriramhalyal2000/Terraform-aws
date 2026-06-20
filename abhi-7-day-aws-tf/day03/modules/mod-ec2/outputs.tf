output "instance_id" {
  value = module.ec2-instance.instance_id
}

output "instance_ip" {
  value = module.ec2-instance.instance_public_ip
}

output "ebs_vol_id" {
  value = module.ec2-instance.ebs_vol_id
}

output "ebs_vol_name" {
  value = module.ec2-instance.ebs_vol_name
}
