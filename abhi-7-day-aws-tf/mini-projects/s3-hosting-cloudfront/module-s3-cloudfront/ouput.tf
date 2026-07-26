output "bucket_id"{
    value = aws_s3_bucket.cloudfront_bucket.id
}
output "bucket_domain_name"{
    value = aws_s3_bucket.cloudfront_bucket.bucket_domain_name
}