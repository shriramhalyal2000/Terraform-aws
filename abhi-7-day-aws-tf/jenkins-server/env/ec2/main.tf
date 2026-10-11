terraform{
    required_providers{
        aws={
            source = "hashicorp/aws"
            version = "~> 5.11.0"
        }
    }
    backend "s3" {
      bucket = "ultron-tfstate-081374579218-us-east-1-an"
      key = "jenkins/ec2/terraform.tfstate"
      region = "us-east-1"
      dynamodb_table = "tf-state-locks"
      encrypt = true
    }
}

provider "aws"{
    region = "us-east-1"
}


module "ec2"{
    source = "../mod/ec2"
    instance_type = "t3.medium"
    ebs_vol_size = 30
    ebs_vol_type = "gp3"
    ebs_encryption = true
    ebs_termination = true
}