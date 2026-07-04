# define data source for vpc
variable "vpc_id"{type = string}
data "aws_vpc" "deployed_vpc"{
    filter{
        name = "tag:Name"
        values = ["module_vpc"]# value must match vpc tag Name
    }
    id = var.vpc_id
}
variable "subnet1_id" {type = string}
data "aws_subnet" "deployed_subnet1"{
    filter{
        name = "tag:Name"
        values = ["public_subnet_1"] # value must match the subnet tag Name
    }
    id = var.subnet1_id
}
# ami data look up
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


# this module used data sources and list resources
resource "aws_instance" "server1"{
    ami = data.aws_ami.amazon_linux_2023.id
    key_name = var.key_name
    instance_type = var.instance_type
    ebs_block_device {
      device_name = var.mount_path
      volume_size = var.volume_size
      volume_type = var.volume_type
      delete_on_termination = true
    }
    iam_instance_profile = var.instance_profile
    vpc_security_group_ids  = [aws_security_group.allow_http_ssh.id]
    # user_data_base64 = filebase64("")
    subnet_id = data.aws_subnet.deployed_subnet1.id
    # private_ip = ""
    tags={
        Name = local.instance_name
    }
}

variable "ingress"{
    description = "ingress rule for inbound traffic to instance"
    type = map(object({
        to_port = number
        from_port = number
        protocol = string
        cidr_blocks = list(string)

    }))
    default={
        http ={from_port = 80,
         to_port = 80, 
         protocol ="tcp", 
         cidr_blocks= ["0.0.0.0/0"] }
        ssh ={from_port = 22, 
        to_port = 22, 
        protocol ="tcp", 
        cidr_blocks = ["0.0.0.0/0"]}
    }
}

resource "aws_security_group" "allow_http_ssh"{
    description = "allow inbound ssh and http traffic from internet to instance"
    vpc_id = data.aws_vpc.deployed_vpc.id

    dynamic "ingress" {
      for_each = var.ingress
      content {
        to_port = ingress.value.to_port
        from_port = ingress.value.from_port
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
}