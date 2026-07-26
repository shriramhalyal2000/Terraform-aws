terraform {
  required_providers {
    aws = {
      version = ">= 5.11.0"
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket  = "ultron-tfstate-081374579218-us-east-1-an"
    region  = "us-east-1"
    key     = "cloudfront-s3/terraform.tfstate"
    encrypt = true
  }
}
provider "aws" {
  region = "us-east-1"
}

module "s3-cloudfront"{
  source = "../module-s3-cloudfront"
  bucket_name = "s3cloudfrontdistributionbucket"
  force_destroy = true
  versioning_status = "Enabled"
  origin_access_name = "s3-cf-oac"
  cloudfront_status = true
  ipv6_status = true
  allowed_methods = ["GET", "HEAD"]
  cached_methods = ["GET", "HEAD"]
  forward_query_string = false
  cookie_forward = "none"
  min_ttl = 0
  max_ttl = 3600
  default_ttl = 86400
  geo_restriction_type = "none"
  cloudfront_default_certificate = true
}