terraform{
    required_providers{
        aws = {
            source = "hashicorp/aws"
            vresion = "~> 6.0"
        }

    }
}

provider "aws"{
    region = "us-east-1"
}