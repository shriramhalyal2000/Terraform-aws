terraform{
    required_providers{
        aws={
            source = "hashicorp/aws"
            version = "~> 6.39.0"
        }
    }
}
provider "aws"{
    region = "us-east-1"
}

resource "aws_vpc" "my_vpc"{
    cidr_block = "10.0.0.0/16"
    tags={
        Name = "my_vpc" # local name of resource to be referenced within terraform
    }
}
