terraform {
  required_providers {
    aws = {
      source   = "hashicorp/aws"
      veresion = "5.11.0"
    }
  }
}


provider "aws" {
  region = "us-east-2"
}