terraform {
  backend "s3" {
    bucket  = "ultron-tfstate-081374579218-us-east-1-an"
    key     = "day03/modules/mod-s3/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

module "mod_tf_s3_bucket" {
  source             = "../../Enviorments/dev/s3"
  aws_s3_bucket_name = "my_bucket_name"
}