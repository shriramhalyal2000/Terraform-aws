resource "aws_s3_bucket" "db-snapshot" {
  bucket = "dev-snapshot-backup"
  tags = {
    Name = "DD-Snapshos"
    Envionments = "Read-Rplicas"
  }
}

resource "aws_s3_bucket_versioning" "db-snapshot-versioned"{
  bucket = aws_s3_bucket.db-snapshot.id
  versioning_configuration {
    status = "Enabled"
  }
}