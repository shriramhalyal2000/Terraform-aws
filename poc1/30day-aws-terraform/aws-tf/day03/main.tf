terraform{
    required_providers{
        # select provider version and source
        aws={
            source= "hashicorp/aws"
            version = "~> 6.39.0"
        }
    }
}
#configure provider 
provider "aws"{
    region = "us-east-1"
    profile = "default"
}

# create resource 
resource "aws_s3_bucket" "demo-bucket" {
    bucket = "ultron-s3-tf-dev-bucket"
    tags = {
        Name = "My Bucket"
        Enviornment = "Dev"
    }
}