terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
      configuration_aliases = [ aws.primary, aws.secondary ]
    }
  }
  backend "s3" {
    bucket  = "ultron-tfstate-081374579218-us-east-1-an"
    key     = "vpc-peer/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true

  }
}
provider "aws" {
  region = "us-east-1"
  alias = "primary"
}
provider "aws"{
  region = "us-west-2"
  alias = "secondary"
}