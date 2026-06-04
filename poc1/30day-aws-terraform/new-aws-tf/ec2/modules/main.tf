terraform {
  backend "s3" {
    bucket  = "ultron-tfstate-081374579218-us-east-1-an"
    key     = "task-ec2/terraform.tfstate"
    encrypt = true
    region  = "us-east-1"
  }
}
provider "aws" {
  region = "us-east-1"
}

# instead of initialising var defaults in vat.tf initialise here and refere them in var and main
module "e2_instance" {
  source         = "../../terraform-ec2"
  ami_id         = "ami-00e801948462f718a"
  instance_type  = "t3.micro"
  key_name       = "us-east-1"
  instance_name  = "my-web-server"
  instance_env   = "Iac-test"
  instance_count = 1
  aws_security_group_name = "http&ssh-sg"
}