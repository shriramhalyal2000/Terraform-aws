output "vpc_id" {
  value = aws_vpc.task_vpc.id
}
output "subnet_id" {
  value = aws_subnet.my_public_sbn.id
}
output "subnet_2_id" {
  value = aws_subnet.public_sbn_2.id
}
output "igw_id" {
  value = aws_internet_gateway.task_vpc_igw.id
}
output "subnet1_az" {
  value = aws_subnet.my_public_sbn.availability_zone
}
output "subnet1_az_id" {
  value = aws_subnet.my_public_sbn.availability_zone_id
}
output "subnet2_az" {
  value = aws_subnet.public_sbn_2.availability_zone
}
output "subnet2_az_id" {
  value = aws_subnet.public_sbn_2.availability_zone_id
}
output "subnet1_public_ip_maps" {
  value = aws_subnet.my_public_sbn.map_public_ip_on_launch
}
output "subnet2_public_ip_maps" {
  value = aws_subnet.my_public_sbn.map_public_ip_on_launch
}
output "sg-id" {
  value = aws_security_group.sg_resource.id
}
output "bucket_id" {
  value = aws_s3_bucket.task_bucket.id
}
output "bucket_arn" {
  value = aws_s3_bucket.task_bucket.arn
}
output "instance1_id" {
  value = aws_instance.task_server_1.id
}
output "instance2_id" {
  value = aws_instance.task_server_2.id
}
output "instance1_arn" {
  value = aws_instance.task_server_1.arn
}
output "instance2_arn" {
  value = aws_instance.task_server_2.arn
}
output "instance1_ip_map" {
  value = aws_instance.task_server_1.public_ip
}
output "instance2_ip_map" {
  value = aws_instance.task_server_2.public_ip
}
output "instance1_profile" {
  value = aws_instance.task_server_1.iam_instance_profile
}
output "instance2_profile" {
  value = aws_instance.task_server_2.iam_instance_profile
}
output "instance1_sg" {
  value = aws_instance.task_server_1.security_groups
}
output "instance2_sg" {
  value = aws_instance.task_server_2.security_groups
}
output "instance1_subnet_id" {
  value = aws_instance.task_server_1.subnet_id
}
output "instance2_subnet_id" {
  value = aws_instance.task_server_1.subnet_id
}