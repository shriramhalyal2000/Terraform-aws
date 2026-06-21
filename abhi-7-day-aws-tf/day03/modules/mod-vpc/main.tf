terraform{
    backend "s3"{
        bucket = "ultron-tfstate-081374579218-us-east-1-an"
        key = "vpc/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
    }
}

module "vpc"{
    source = "../../Enviorments/dev/vpc"
    cidr_block_vpc = "10.0.0.0/16"
    public_subnet_cidr = "10.0.1.0/16"
    cidr_block_rt = "0.0.0.0/0"
}