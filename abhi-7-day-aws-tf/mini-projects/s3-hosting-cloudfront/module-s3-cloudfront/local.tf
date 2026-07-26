locals{
    bucket_name = "s3-cloudfront-static-website-bucket"
    s3_origin_id = "s3-${aws_s3_bucket.cloudfront_bucket.id}"
    cloudfront_env = "s3-content-serve-cloudfront-distro"
}