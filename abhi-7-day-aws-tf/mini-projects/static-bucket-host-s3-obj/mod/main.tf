# create a sns topic and subscript for email notification

resource "aws_sns_topic" "bucket_alert" {
  name = var.topic_name
  tags = {
    Name        = local.Name
    Enviornment = local.Enviornment
  }
}
resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.bucket_alert.arn
  protocol  = "email"
  endpoint  = var.topic_endpoint
}
# if there pre-exits a iam policy data for sns topic , use policy argument directly inside sns topic, but not if both are created in same  script, 
# that causes loop as they both depend on each other during recoude creation ending up in cycle 
resource "aws_sns_topic_policy" "allow_eventbridge" {
  arn    = aws_sns_topic.bucket_alert.arn
  policy = data.aws_iam_policy_document.allow_event.json
}

# crete s3 bucket and configure security with wonership controls, acl and public access

resource "aws_s3_bucket" "website_bucket" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = {
    Name        = local.Name
    Enviornment = local.Enviornment
  }
}
resource "aws_s3_bucket_ownership_controls" "website_bucket" {
  depends_on = [aws_s3_bucket.website_bucket]
  bucket     = aws_s3_bucket.website_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_notification" "website_bucket" {
  depends_on = [data.aws_iam_policy_document.allow_event, 
  aws_sns_topic_policy.allow_eventbridge] # important, for this to have running sns topic polcy before creattion
  bucket     = aws_s3_bucket.website_bucket.id

  topic {
    topic_arn     = aws_sns_topic.bucket_alert.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".log"
  }
}
resource "aws_s3_bucket_public_access_block" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "website_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.website_bucket]
  bucket     = aws_s3_bucket.website_bucket.id
  acl        = "private"
}
resource "aws_s3_bucket_versioning" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id
  versioning_configuration {
    status = var.versioning
  }
}
# define a aws s3 object 

resource "aws_s3_object" "website_bucket" {
  key          = "page.html"
  bucket       = aws_s3_bucket.website_bucket.id
  source       = "${path.module}/static-website/page.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/static-website/page.html")
}

# define cloudwatch event bridge 

resource "aws_cloudwatch_event_rule" "website_bucket" {
  name        = var.event_rule_name
  description = "capture object uploads on website bucket"

  event_pattern = jsonencode({
    source      = ["aws.s3"]
    detail-type = ["Object Created"]
    detail = {
      bucket = {
        name = [aws_s3_bucket.website_bucket.id]
      }
    }
  })
  tags = {
    Name        = local.Name
    Enviornment = local.Enviornment
  }
}

resource "aws_cloudwatch_event_target" "website_bucket" {
  target_id = "SendToSNS"
  rule      = aws_cloudwatch_event_rule.website_bucket.name
  arn       = aws_sns_topic.bucket_alert.arn
}

resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website_bucket.bucket
  policy = data.aws_iam_policy_document.allow_cf.json
}

# create cloudfront distribution and OriginAccessControl 
#for this s3 buckt to host static website page

resource "aws_cloudfront_origin_access_control" "website_bucket" {
  name                              = "${var.bucket_name}-oac"
  description                       = "Origin access control fro cloudfront to access private bucket hosting static website"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "website_bucket" {
  origin {
    domain_name              = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.website_bucket.id
    origin_id                = local.origin_id
  }

  enabled             = true
  is_ipv6_enabled     = false
  comment             = "S3WebSite"
  default_root_object = "page.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.origin_id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
  tags = {
    Enviornment = local.Enviornment
  }
}