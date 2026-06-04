output "instance_id" {
  value = aws_instance.my_server[*].id
}

output "public_ip" {
  value = aws_instance.my_server[*].public_ip
}

output "instance_name" {
    value = aws_instance.my_server[*].tags_all["Name"]
}