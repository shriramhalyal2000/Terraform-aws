resource "aws_s3_bucket" "env-dev-s3"{
    bucket =  var.aws_s3_bucket_name

    tags={
        Name = local.bucket_name_tag
        Enviornment = local.bucket_enviornment_tag
    }
}

resource "aws_s3_bucket_versioning" "env-dev-s3-versioned"{
    bucket = aws_s3_bucket.env-dev-s3.id

    versioning_configuration {
      status = "Enabled"
    }
}