output "instance_id" {
  value = { for k, v in aws_instance.web : k => v.id }
}

output "instance_public_ip" {
  value = { for k, v in aws_instance.web : k => v.public_ip }
}

output "instance_public_subnet" {
  value = { for k, v in aws_instance.web : k => v.subnet_id }
}