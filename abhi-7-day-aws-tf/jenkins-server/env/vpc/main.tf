terraform{
    required_providers{
        aws={
            source = "hashicorp/aws"
            version = "~> 5.11.0"
        }
    }
    backend "s3" {
      bucket = "ultron-tfstate-081374579218-us-east-1-an"
      key = "jenkins/terraform.tfstate"
      region = "us-east-1"
      dynamodb_table = "tf-state-locks"
      encrypt = true
    }
}

provider "aws"{
    region = "us-east-1"
}

module "vpc" {
  source = "../../mod/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_region = "us-east-1"
  subnet_cidr = "10.0.1.0/24"
}
