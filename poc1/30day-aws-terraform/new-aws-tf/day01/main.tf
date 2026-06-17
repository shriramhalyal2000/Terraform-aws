resource "aws_s3_bucket" "tf-bucket"{
    bucket = "ultron-s3-infra"
    # acl    = "private"

    tags={
        Name = "My Infra-Bucket"
        Envionment = "Learn-env"
    }
}
#creating a sepreate resource for versioning the bucket by fetching its ID

resource "aws_s3_bukcet_versioning" "tf-bucket-versioned"{ # seperate resource referencing the same s3 bucket to be versioned
    bucket = aws_s3_bucket.tf-bucket.ID
    versioning_configuration ={
        status = "enabled"
    }
}