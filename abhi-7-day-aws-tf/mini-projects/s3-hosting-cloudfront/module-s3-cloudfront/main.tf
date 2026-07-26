resource "aws_s3_bucket" "cloudfront_bucket" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
  tags={
    Name = local.bucket_name
  }
}
resource "aws_s3_bucket_versioning" "bucket_versiong" {
  bucket = aws_s3_bucket.cloudfront_bucket.id #implicit dependency
  versioning_configuration {
    status = var.versioning_status
  }
}
resource "aws_s3_bucket_public_access_block" "bucket_policy" {
  bucket                  = aws_s3_bucket.cloudfront_bucket.id # implicit dependency
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_policy" "allow_cf"{
    depends_on = [ aws_s3_bucket_public_access_block.bucket_policy]
    bucket = aws_s3_bucket.cloudfront_bucket.id
    policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
        "Sid": "AllowCloudFront",
        "Effect": "Allow",
        "Principal": {
            "AWS": "cloudfront.amazonaws.com"
        },
        "Action": [
            "s3:GetObject",
            "s3:ListBucket"
        ],
        "Resource": "${aws_s3_bucket.cloudfront_bucket.arn}/*"
        Condition={
            StringEquals={
                "AWS:SourceArn" = aws_cloudfront_distribution.s3_distro.arn
            }
        }
        }
    ]
})
}

resource "aws_s3_bucket_object" "website_object"{
    bucket = aws_s3_bucket.cloudfront_bucket.id
    for_each = fileset("${path.module}/www", "**/*")
    key = each.value
    source = "${path.module}/www/${each.value}"
    etag = filemd5("${path.module}/www/${each.value}") # convert to thois format from all form
    content_type = lookup({
    "html" = "text/html",
    "css"  = "text/css",
    "js"   = "application/javascript",
    "json" = "application/json",
    "png"  = "image/png",
    "jpg"  = "image/jpeg",
    "jpeg" = "image/jpeg",
    "gif"  = "image/gif",
    "svg"  = "image/svg+xml",
    "ico"  = "image/x-icon",
    "txt"  = "text/plain"
  }, split(".", each.value)[length(split(".", each.value)) - 1], "application/octet-stream")
}
resource "aws_cloudfront_distribution" "s3_distro" {
  origin {
    domain_name              = aws_s3_bucket.cloudfront_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.origin_acccess.id
    origin_id                = local.s3_origin_id # origin bucket bucket id
  }

  enabled             =  var.cloudfront_status #true
  is_ipv6_enabled     =  var.ipv6_status #ftrue
  comment             = "poc with free tier and s3 static website hosting"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = var.allowed_methods#[ "GET", "HEAD"]
    cached_methods   = var.cached_methods #["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = var.forward_query_string

      cookies {
        forward = var.cookie_forward #"none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                =  var.min_ttl #0
    default_ttl            = var.default_ttl # 3600
    max_ttl                = var.max_ttl # 86400
  }
  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
    }
  }

  tags = {
    Environment = local.cloudfront_env
  }

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
  }
}

resource "aws_cloudfront_origin_access_control" "origin_acccess" {
  name                             = var.origin_access_name
  description                      = "fetch content from s3"
  origin_access_control_origin_type = "s3"
  signing_behavior                 = "always"
  signing_protocol                 = "sigv4"
}