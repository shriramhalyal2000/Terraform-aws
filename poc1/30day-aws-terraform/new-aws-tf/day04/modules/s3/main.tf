resource "aws_s3_bucket" "my-res-bucket"{
    bucket = "ultron-s3-res-bucket"

    tags = {
        Name = "new-dev1-bucket"
        Enviornment = var.Enviornment 
    }
}

resource "aws_s3_bucket_versioning" "my_versioned_bucket"{
    bucket = aws_s3_bucket.my-res-bucket.id

    versioning_configuration {
      status = Enabled
    }
}