resource "aws_s3_bucket" "my_bucket"{
    bucket = "ultron-s3-iac-infra"

    tags={
        Name = "infra"
        Envionment = "learn1"
    }
}

resource "aws_s3_bucket_versioning" "versioned_bucket"{
    bucket = aws_s3_bucket.my_bucket.id

    versioning_configuration {
      status = "Enabled"
    }
}