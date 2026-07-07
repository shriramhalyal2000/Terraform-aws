output "instance1_id"{
    value = aws_instance.vpc1_instance.id
}
output "instance1_public_ip"{
    value = aws_instance.vpc1_instance.public_ip
}
output "instance1_private_ip"{
    value = aws_instance.vpc1_instance.private_ip
}
output "instance2_id"{
    value = aws_instance.vpc2_instance.id
}
output "instance2_public_ip"{
    value = aws_instance.vpc2_instance.public_ip
}
output "instance2_private_ip"{
    value = aws_instance.vpc2_instance.private_ip
}
