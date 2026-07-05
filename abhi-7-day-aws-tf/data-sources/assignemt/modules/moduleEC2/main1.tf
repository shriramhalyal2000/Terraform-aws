# data look up for subnet1

data "aws_subnet" "az1" {
  filter {
    name   = "tag:Name"
    values = ["public_subnet_1"]
  }
}
# data source look up for subnet 2
data "aws_subnet" "az2" {
  filter {
    name   = "tag:Name"
    values = ["public_subnet2"]
  }
}
# data source look up for ami al
data "aws_ami" "amazon_linux_2023" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# define a local to populate 2 subnets with 2 servers each

locals {
  web_servers = {
    "server1" = { subnet_id = data.aws_subnet.az1.id }
    "server2" = { subnet_id = data.aws_subnet.az1.id }
    "server3" = { subnet_id = data.aws_subnet.az2.id }
    "server4" = { subnet_id = data.aws_subnet.az2.id }
  }
}
# populate the subnet serves in resource to launch

resource "aws_instance" "web" {
  for_each = local.web_servers

  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t3.micro"
  key_name               = "us-east-1"
  iam_instance_profile   = "ec2-ssm-role"
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  ebs_block_device {
    device_name           = var.mount_path
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    delete_on_termination = true
  }
}