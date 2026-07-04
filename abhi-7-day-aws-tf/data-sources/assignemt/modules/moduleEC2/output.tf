output "instance_id"{
    value = aws_instance.server1.id
}
output "instance_dns"{
    value = aws_instance.server1.public_dns
}
output "instance_public_ip" {
  value = aws_instance.server1.public_ip
}
output "instance_sg_id"{
    value = aws_instance.server1.vpc_security_group_ids
}
output "instance_key"{
    value = aws_instance.server1.key_name
}
output "instance_ebs_vol"{
    value = aws_instance.server1.ebs_block_device
}