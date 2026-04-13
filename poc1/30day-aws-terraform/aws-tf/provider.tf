terraform{
    required_providers{
        aws={
            source= "hashicorp/aws"
            version= "6.39.0"
        }
    }
    required_version = "1.14.8"
}

provider "aws"{
    region = "us-east-1"
    profile= "defult" #the one configured in aws/credentials
}