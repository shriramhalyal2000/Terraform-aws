# creating root mod

terraform{
    required_providers{
        aws={
            source = "hashicorp/aws"
            version = ">= 5.11.0"
        }
    }
    backend "s3"{
        bucket = "ultron-tfstate-081374579218-us-east-1-an"
        key = "eks/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "tf-state-locks"
        encrypt = true
    }
}
module "eks"{
    source = "../mod"
    vpc_cidr = "10.0.0.0/16"
    sub1_cidr = "10.0.1.0/24"
    sub2_cidr = "10.0.2.0/24"
}