# define ec2 instances per 2 subnet with data source look up

variable "subnet1_id"{
    type = string 
    description = "for data source vpc id"
}
data "aws_subnet" "az1"{
    filter{
        name = "tag:Name"
        values = ["tf-task-subnet1"]
    }
    id = var.subnet1_id
}
variable "subnet2_id" {
  type = string
  description = "for data source lookup for subnet2 id"
}
data "aws_subnet" "az2"{
    filter{
        name = "tag:Name"
        values = ["tf-task-subnet2"]
    }
    id = var.subnet2_id
}
variable "vpc_id" {
    type = string
    description = "vpc id look up for security group attachment"
}
data "aws_vpc" "vpc"{
    filter{
        name = "tag:Name"
        values = ["tf-task-vpc"]
    }
    id = var.vpc_id
}
data "aws_ami" "amazon_linux_2023"{
    owners = ["amazon"]
    most_recent = true
    filter {
      name = "name"
      values = ["al2023-ami-*"]
    }
    filter {
      name = "virtualization-type"
      values =["hvm"]
    }
}
# define a http ssh inbound traffic allow sg
resource "aws_security_group" "allow_ssh_http"{
    vpc_id = var.vpc_id
    dynamic "ingress" {
      for_each = var.ingress
      content {
        from_port = ingress.value.from_port
        to_port = ingress.value.to_port
        protocol = ingress.value.protocol
        cidr_blocks = ingress.value.cidr_blocks
      }
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags={
        Name = local.sg_name
    }
}

resource "aws_instance" "web"{
    for_each = local.web_server

    ami =  data.aws_ami.amazon_linux_2023.id
    instance_type = var.instance_type
    iam_instance_profile = var.iam_instance_profile
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
    ebs_block_device {
      device_name = var.device_name
      volume_size = var.volume_size
      volume_type = var.volume_type
      delete_on_termination = true
    }
    tags={
        Name = each.key
    }
}