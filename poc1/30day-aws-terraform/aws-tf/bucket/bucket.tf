terraform{
    backend "s3" {
      bucket = "ultron-tfstate-081374579218-us-east-1-an"
      key = "test/terraform.tfstate"
      region = "us-east-1"
      encrypt = true
      use_lockfile = true
    }
    required_providers{
        aws={
            source = "hashicorp/aws"
            version = "~> 6.0"
        }
    }
}

provider aws{
    region = "us-east-1"
}

locals { #variables can be referenced here 
    ps = "prod-store"
    production_bucket = "prod_buck"
    bucket_name = "${var.bucket}-bucket-${var.enviornment}"
}

variable "enviornment"{
    default = "Dev"
}

variable "bucket"{ #cant reference locals in here but cvariables can be referenced in locals
    default = "ultron-s3-tf"
}
resource "aws_s3_bucket" "my-bucket"{
    bucket = local.bucket_name

    tags={
        Enviornment = var.enviornment
        Name = local.ps
    }
}