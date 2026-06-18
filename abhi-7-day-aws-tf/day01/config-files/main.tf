resource "aws_instance" "demo-ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = local.instance_name
  }

}

# define security group
resource "aws_security_group" "tf-instace-sg" {
  name        = "${var.aws_security_group}-sg"
  description = "For HTTP and SSH configured ec2 instance sg"


  tags = {
    Name = local.security_group_name
  }
}

# configure http port and attach to the sg
resource "aws_vpc_security_group_ingress_rule" "http-sg" {
  security_group_id = "${var.aws_security_group}.id"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "80"
  ip_protocol       = "tcp"
  to_port           = 80
}
# configure ssh port and attach to the sg
resource "aws_vpc_security_group_ingress_rule" "ssh-sg" {
  security_group_id = "${var.aws_security_group}.id"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
}

# define ebs volume of gp2
resource "aws_ebs_volume" "demo-ec2-vol" {
    availability_zone = var.availability_zone  
    size = var.size
    type = var.type

    tags={
        Name="Tf-instance-ebs-vol"
    }
}

#attach the ebs vol on instance

resource "aws_volume_attachment" "abs-attach"{
    device_name = var.device_name
    volume_id = aws_ebs_volume.demo-ec2-vol.id
    instance_id = aws_instance.demo-ec2.id
}
