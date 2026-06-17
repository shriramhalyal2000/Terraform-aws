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
  key-name           = "us-east-1.pem"
  ami                = "ami-0521cb2d60cfbb1a6"
  instance_type      = "t3.micro"
  aws_security_group = "http-ssh-sg"
  type               = "gp3"
  size               = "15"
  device_name        = "dev/sdb"
  volume_id          = aws_ebs_volume.demo-ec2-vol.volume_id
  availability_zone  = "us-east-1"
}