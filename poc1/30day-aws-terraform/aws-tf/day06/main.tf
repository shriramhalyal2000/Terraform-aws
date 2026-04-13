
provider "aws"{
    region = "us-east-1"
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