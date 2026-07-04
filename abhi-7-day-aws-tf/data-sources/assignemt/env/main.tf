terraform {
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "5.11.0"
        }
    }
}

provider "aws"{
    region = "us-east-1"
}

terraform{
    backend "s3"{
        bucket = "ultron-tfstate-081374579218-us-east-1-an"
        key = "data-source/terraform.tfstate"
        region= "us-east-1"
        encrypt = true
    }
}
# this module is configured with vpc networking components
module "vpc"{
    source = "../modules/moduleVPC"
    vpc_cidr = "10.0.0.0/16"
    subnet1_cidr = "10.0.1.0/24"
    subnet1_az = "us-east-1a"
    subnet2_cidr = "10.0.2.0/24"
    subnet2_az = "us-east-1b"
}
# this module is for ec2 to provision in newly created vpc
module "ec2"{
    source = "../modules/moduleEC2"
    key_name = "us-east-1"
    instance_type = "t3.micro"
    instance_profile = "ec2-ssm-role"
    volume_size = 8
    volume_type = "gp3"
    mount_path = "/dev/sdb"
    vpc_id = module.vpc.vpc_id
    subnet1_id = module.vpc.subnet1_id
}