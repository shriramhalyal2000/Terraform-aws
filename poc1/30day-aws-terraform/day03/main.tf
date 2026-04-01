terraform{
    required_providers{
        aws={
            source = "hashicorp/aws"
            version = "~>6.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}
#create a s3 bucket
resource "aws_s3_bucket" "demo-bucket" {
  bucket = "ultron-s3-terraform-bucket-01"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}