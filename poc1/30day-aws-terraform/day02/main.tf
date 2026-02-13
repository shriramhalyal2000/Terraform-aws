#terraform provider block
terraform{
    required_providers{
        aws={
            source = "hashicorp/aws"
            version = "~>6.0"
        }
    }
}
# configure aws region
provider "aws" {
    region = "us-east-1"
}
#configure aws reources
resource "aws_vpc" "example" {
    cidr_block = "10.0.0.0/16"
}