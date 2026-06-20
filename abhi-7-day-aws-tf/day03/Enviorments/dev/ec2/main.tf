# ec2 instance spec definitions
resource "aws_instance" "demo_instance" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  region                 = var.instance_region
  key_name               = var.instance_key_name
  vpc_security_group_ids = [aws_security_group.http_ssh.id]
  iam_instance_profile = var.iam_instance_profile
}
# security group name for the ec2 instance
resource "aws_security_group" "http_ssh" {
  name        = var.aws_security_group_rule
  description = "The security group rule for ssh and http ingress traffic"
  # instead of definign seperate resource for sg-paramenetes,
  # define them sinside the security group resource multiple ingress and egress firewall
  
  # http ingress sg rule
  ingress {
    description = "HTTP traffic from anywhere"
    from_port = var.from_port_http
    to_port = var.to_port_http
    protocol = var.ip_protocol
    cidr_blocks = variable.cidr_blocks

  }

  # ssh ingress sg -rule
  ingress {
    description = "ssh trffic from anywhere to instance"
    from_port = var.from_port_ssh
    to_port = var.to_port_ssh
    protocol = var.ip_protocol
    cidr_blocks = variable.cidr_blocks

  }

  # http and ssh egress sg-rule
  egress {
    description = "outbound traffic from instance to internet"
    from_port = 0
    to_port = 0
    protocol = "-1" # represents all kinds of protocol given its prot range set from and to both 0
    cidr_blocks = variable.cidr_blocks

  }
  tags = {
    Name = local.aws_security_group_env_name
  }
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