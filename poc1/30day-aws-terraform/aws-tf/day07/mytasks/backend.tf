terraform{
    backend "s3"{
        bucket = "ultron-tfstate-081374579218-us-east-1-an"
        key = "task1/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true
        }
}