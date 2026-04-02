terraform{
    required_providers{
        aws={
            source= "hashicopr/aws"
            version= "~>3.38.00"
        }
    }
    required_version = "1.14.8"
}

provider "aws"{
    region = "us-east-1"
    output_type = "json"
}