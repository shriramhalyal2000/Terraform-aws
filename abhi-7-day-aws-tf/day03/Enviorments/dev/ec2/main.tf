# ec2 instance spec definitions
resource "aws_instance" "demo_instance" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  region                 = var.instance_region
  key_name               = var.instance_key_name
  vpc_security_group_ids = [aws_security_group.http_ssh.id]
}
# security group name for the ec2 instance
resource "aws_security_group" "http_ssh" {
  name        = var.aws_security_group_rule
  description = "The security group rule for ssh and http ingress traffic"
  tags = {
    Name = local.aws_security_group_env_name
  }
}
# insgress rule definition for the security group of type ssh
resource "aws_vpc_security_group_ingress_rule" "ssh_sg" {
  security_group_id = aws_security_group.http_ssh.id

  cidr_ipv4   = var.cidr_ipv4
  to_port     = var.to_port_ssh
  from_port   = var.from_port_ssh
  ip_protocol = var.ip_protocol
}
# ingress rule definition for the security group of type http
resource "aws_vpc_security_group_ingress_rule" "http_sg" {
  security_group_id = aws_security_group.http_ssh.id

  cidr_ipv4   = var.cidr_ipv4
  to_port     = var.to_port_http
  from_port   = var.from_port_http
  ip_protocol = var.ip_protocol
}
# egress rule definition for the security group of type http
resource "aws_vpc_security_group_egress_rule" "http_sg" {
  security_group_id = aws_security_group.http_ssh.id

  cidr_ipv4   = var.cidr_ipv4
  to_port     = var.to_port_http
  from_port   = var.from_port_http
  ip_protocol = var.ip_protocol
}
# egress rule definition for the security group of type ssh
resource "aws_vpc_security_group_egress_rule" "ssh_sg" {
  security_group_id = aws_security_group.http_ssh.id

  cidr_ipv4   = "172.31.0.0/16"
  to_port     = var.to_port_ssh
  from_port   = var.from_port_ssh
  ip_protocol = var.ip_protocol

}
# ebs vol to attach to instance definition
resource "aws_ebs_volume" "instance_vol" {
  availability_zone = aws_instance.demo_instance.availability_zone #use same var as of instance region
  size              = var.ebs_instance_vol_size
  type              = var.ebs_instance_vol_type

  tags = {
    Name = local.ebs_vol_env_name
  }
}

resource "aws_volume_attachment" "attach_ebs_vol" {
  device_name = var.ebs_attach_dir
  volume_id   = aws_ebs_volume.instance_vol.id
  instance_id = aws_instance.demo_instance.id
}