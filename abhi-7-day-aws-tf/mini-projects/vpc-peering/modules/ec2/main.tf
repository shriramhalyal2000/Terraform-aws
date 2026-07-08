# create two ec2 instance with icmp protocol and instance should accept traffic 
# from both vpc, so add vpc cidrs in instances ec2-sg1-cidr_block_secondary_vpc2

# security group from primary vpc

resource "aws_security_group" "sg-1"{
  provider = aws.primary
  name = "vpc1-sg"
  description = "allows ssh, http, imcp and traffic from vpc2 on to vpc1 instance"
  vpc_id = data.aws_vpc.vpc1.id

  dynamic "ingress" {
    for_each = var.ingress1
    content{
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      cidr_blocks = ingress.value.cidr_block
      protocol = ingress.value.protocol
    }
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags={
    Name = "vpc1-security_group"
  }
}

resource "aws_instance" "vpc1_instance"{
  provider = aws.primary
  ami = data.aws_ami.vpc1ami.id
  instance_type = var.instance_type
  key_name = var.instance_key
  subnet_id = data.aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.sg-1.id]
  iam_instance_profile = var.iam_instance_role
  ebs_block_device{
    volume_size = var.volume_size
    volume_type = var.volume_type
    device_name = var.device_name
    delete_on_termination = true
  }
  tags={
    Name = "vpc1-server"
  }
}

# security group for vpc2 instance

resource "aws_security_group" "sg-2"{
  provider = aws.secondary
  vpc_id = data.aws_vpc.vpc2.id
  description = "allows ssh, hhtp, impc from vpc1 and internet and vpc1 pings"
  name = "vpc2-sg"

  dynamic "ingress" {
    for_each = var.ingress2
    content{
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_block
    }
  }
  tags={
    Name = "vpc2-sg"
  }
}


resource "aws_instance" "vpc2_instance"{
  provider = aws.secondary
  ami = data.aws_ami.vpc2ami.id
  ebs_block_device{
    volume_size = var.volume_size
    volume_type = var.volume_type
    device_name = var.device_name
    delete_on_termination = true
  }
  instance_type = var.instance_type
  key_name = var.instance_key2
  subnet_id = data.aws_subnet.subnet2.id
  iam_instance_profile = var.iam_instance_role
  vpc_security_group_ids = [aws_security_group.sg-2.id]
  tags={
    Name = "vpc2-server"
  }
}