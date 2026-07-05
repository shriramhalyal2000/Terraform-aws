terraform{
    required_providers {
      aws={
        source = "hashicorp/aws"
        version = "5.11.0"
      }
    }
    backend "s3" {
        bucket = "ultron-tfstate-081374579218-us-east-1-an"
        key = "task-vpc1/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
    }
}