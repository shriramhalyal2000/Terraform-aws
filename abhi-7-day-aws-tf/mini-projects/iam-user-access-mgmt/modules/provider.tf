terraform{
    required_providers{
        aws={
            source = "hashicorp/aws"
            version = "5.11.0"
        }
    }
    backend "s3"{
        bucket = "ultron-tfstate-081374579218-us-east-1-an"
        key = "iam-users-list/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
    }
}
provider "aws"{
    region = var.primary_reg
    alias = "primary"
}
variable "primary_reg" {
    description = "primary provider region"
    type = string
    default = "us-east-1"
}
