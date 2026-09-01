terraform{
    required_providers {
      aws={
        source = "hashicorp/aws"
        version = ">= 5.11.0"
      }
    }
    backend "s3"{
        bucket = "ultron-tfstate-081374579218-us-east-1-an"
        key = "vault-instance/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "tf-state-locks"
        encrypt = true
    }
}

provider "aws"{
    region = "us-east-1"
}

module "ec2"{
    source = "../module/ec2"
    instance_type = "t3.micro"
    key_name = "us-east-1"
    ebs_encryption = true
    ebs_vol = "15"
    ebs_type = "gp3"
    ebs_name = "tf-vault"
}