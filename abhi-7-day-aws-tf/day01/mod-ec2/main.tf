terraform {
  backend "s3" {
    bucket  = "ultron-tfstate-081374579218-us-east-1-an"
    key     = "module-ec2/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

module "ec2_instance" {
  source             = "../config-files/"
  key_name           = "us-east-1"
  ami                = "ami-0521cb2d60cfbb1a6"
  instance_type      = "t3.micro"
  aws_security_group = "http-ssh"
  type               = "gp3"
  size               = "15"
  device_name        = "dev/sdb"
  availability_zone  = "us-east-1a"
}