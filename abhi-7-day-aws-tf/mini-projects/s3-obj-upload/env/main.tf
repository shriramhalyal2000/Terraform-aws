terraform{
    required_providers{
        aws={
            source = "hashicorp/aws"
            version = "> 5.11.0"
        }
    }
    backend "s3"{
        bucket = "ultron-tfstate-081374579218-us-east-1-an"
        key = "s3-obj-up/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
    }
}

module "object-upload"{
    source = "../mods"
    bucket_name = "poc-obj-upload"
    sns_topic_name = "s3-bucket-alert-topic"
    email = "sshalyal42@gmail.com"
}