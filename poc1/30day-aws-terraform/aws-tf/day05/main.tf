terraform{
    backend "s3"{
        bucket = "ultron-tfstate-081374579218-us-east-1-an"
        key = "prod/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true
        }
    required_providers{
        aws={
            source = "hashicorp/aws"
            version = "~> 6.0"
        }
    }
}

provider "aws"{
    region = "us-east-1"
}

locals{
    bucket_version = "prod-bucket"
    Enviornment = "prod-env"
    Name = "Prod-01"
    bucket_name = "${var.bucket_name}-bucket"
}

variable "bucket_name"{
    default = "ultrons3-tf-"
}

resource "aws_s3_bucket" "example"{
    bucket = local.bucket_name
    
    tags={
        Enviornment = local.Enviornment
        Name = local.Name
    }
}

resource aws_vpc "my_vpc"{
    cidr_block = "10.0.0.0/16"
     
}