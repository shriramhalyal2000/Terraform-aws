output "instance_id"{
    value = aws_instance.jenkins.id
}
output "instance_type"{
    value = aws_instance.jenkins.instance_type
}
output "instance_state"{
    value = aws_instance.jenkins.instance_state
}
output "instance_profile"{
    value = aws_instance.jenkins.iam_instance_profile
}
output "instance_public_ip"{
    value = aws_instance.jenkins.public_ip
}
output "instance_subnet"{
    value = aws_instance.jenkins.subnet_id
}
output "instance_az"{
    value = aws_instance.jenkins.availability_zone
}
output "instance_sg"{
    value = aws_instance.jenkins.security_groups
}
output "instance_key_pair"{
    value = aws_instance.jenkins.key_name
}