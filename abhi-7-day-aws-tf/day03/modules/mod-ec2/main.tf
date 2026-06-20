terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "ec2-instance" {
  source                  = "../Enviorments/dev"
  instance_ami            = "ami-0521cb2d60cfbb1a6"
  instance_region         = "us-east-1"
  instance_type           = "t3.micro"
  instance_key_name       = "us-east-1"
  ip_protocol             = "tcp"
  ebs_instance_vol_type   = "gp3"
  ebs_instance_vol_size   = 15
  to_port_http            = 80
  from_port_http          = 80
  cidr_blocks             = ["0.0.0.0/0"]
  to_port_ssh             = 22
  from_port_ssh           = 22
  aws_security_group_rule = "http and ssh "
  ebs_attach_dir          = "/dev/sdh"

}