resource "aws_s3_bucket" "mod_tf_s3_bucket"{
    bucket =  var.aws_s3_bucket_name

    tags={
        Name = local.bucket_name_tag
        Enviornment = local.bucket_enviornment_tag
    }
}

resource "aws_s3_bucket_versioning" "mod_tf_s3__bucket_versioned"{
    bucket = aws_s3_bucket.mod_tf_s3_bucket.id

    versioning_configuration {
      status = "Enabled"
    }
}