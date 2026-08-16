terraform{
    required_providers{
        aws={
            source = "hashicorp/aws"
            version = ">= 5.11.0"
        }
    }
    backend "s3"{
        bucket = "ultron-tfstate-081374579218-us-east-1-an"
        key = "cloudfront-website/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
    }
}

module "website"{
    source = "../mod"
    topic_endpoint = "sshalyal42@gmail.com"
    topic_name = "bucket-alert"
    bucket_name = "website-hosting-bucket-cloudfront"
    versioning = "Enabled"
    event_rule_name = "bucket-alert"
}