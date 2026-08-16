# allows event bridge to publish message in sns topic
data "aws_iam_policy_document" "allow_event"{
    statement {
      sid = "AllowEventbridgePublishMessage"
      effect = "Allow"

      principals {
        type = "Service"
        identifiers = ["s3.amazonaws.com","events.amazonaws.com"]
      }
      actions = ["sns:Publish"]
      resources = [aws_sns_topic.bucket_alert.arn]
    }
}

# policy toaccess bucket objects by cloudfront distribution

data "aws_iam_policy_document" "allow_cf"{
    statement {
      sid = "AllowCloudFrontAccessBucket"
      effect = "Allow"

      principals { # who wants access to resource with effects
        type = "Service"
        identifiers = ["cloudfront.amazonaws.com"]
      }
      actions = ["s3:GetObject"]
      resources = ["${aws_s3_bucket.website_bucket.arn}/*"]

      condition { #grants access only to this cloudfront resource
        test = "StringEquals"
        variable = "AWS:SourceArn"
        values = [aws_cloudfront_distribution.website_bucket.arn]
      }
    }
}