output "instance_id" {
  value = aws_instance.demo_instance.id
}
output "instance_public_ip" {
  value = aws_instance.demo_instance.public_ip
}

output "ebs_vol_id" {
  value = aws_ebs_volume.instance_vol.id
}

output "ebs_vol_name" {
  value = aws_ebs_volume.instance_vol.tags_all
}