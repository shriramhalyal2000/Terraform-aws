output "instance_id" {
  value = aws_instance.demo-ec2.id
}

output "eip" {
  value = aws_instance.demo-ec2.public_ip
}

output "instance_name" {
  value = aws_instance.demo-ec2.tags_all
}

output "volume_id"{
  value = aws_ebs_volume.demo-ec2-vol.volume_id
}