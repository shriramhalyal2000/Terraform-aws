output "instance_id" {
  value = aws_instance.demo_ec2.id
}

output "eip" {
  value = aws_instance.demo_ec2.public_ip
}

output "instance_name" {
  value = aws_instance.demo_ec2.tags[Name]
}

output "volume_id"{
  value = aws_ebs_volume.demo_ec2_vol.id
}