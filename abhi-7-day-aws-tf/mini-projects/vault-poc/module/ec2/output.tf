output "instance_ipv4"{
    value = aws_instance.vault.public_ip
}
output "instance_id"{
    value = aws_instance.vault.id
}
output "instance_role"{
    value = aws_instance.vault.iam_instance_profile
}
output "instance_state"{
    value = aws_instance.vault.instance_state
}
output "ebs_vol"{
    value = aws_instance.vault.ebs_block_device
}
output "instance_region"{
    value = aws_instance.vault.region
}