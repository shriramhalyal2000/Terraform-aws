# create sns topic and subscription

resource "aws_sns_topic" "s3_alerts"{
    name = var.sns_topic_name
}
resource "aws_sns_topic_subscription" "email_subscription"{
    topic_arn = aws_sns_topic.s3_alerts.arn
    protocol = "email"
    endpoint = var.email # email address for sns topic to publish message
}

# create s3 bucket ad configure security with public access block, 
# bucket acl, bucket ownership, and s3 object

resource "aws_s3_bucket" "upload_bucket"{
    bucket = var.bucket_name
    force_destroy = true

    tags={
        Name = local.Name
        Enviornment = local.Enviornment
    }
}
# enable event bridge notification foro the bucket
resource "aws_s3_bucket_notification" "upload_bucket"{
    bucket = aws_s3_bucket.upload_bucket.id
    eventbridge = true
}

resource "aws_s3_bucket_ownership_controls" "upload_bucket"{
    bucket = aws_s3_bucket.upload_bucket.id
    rule{
        object_ownership = "BucketOwnerPreferred"
    }
}
resource "aws_s3_bucket_public_access_block" "upload_bucket"{
    bucket = aws_s3_bucket.upload_bucket.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}
resource "aws_s3_bucket_acl" "upload_bucket"{
    depends_on = [ aws_s3_bucket_ownership_controls.upload_bucket,
     aws_s3_bucket_public_access_block.upload_bucket ]
    bucket = aws_s3_bucket.upload_bucket.id
    acl = "private"
}

resource "aws_s3_object" "local_upload"{
    depends_on = [ aws_s3_bucket_ownership_controls.upload_bucket, 
    aws_s3_bucket_public_access_block.upload_bucket, 
    aws_sns_topic_subscription.email_subscription]
    key = "webpage"
    bucket = aws_s3_bucket.upload_bucket.id
    source = "${path.module}/obj-file/page.html"
    content_type = "text/html"
    etag = filemd5("${path.module}/obj-file/page.html")
}

# create event notification for s3 with cloudwatch events

resource "aws_cloudwatch_event_rule" "object_upload"{
    name = "capture-object-upload"
    description = "sends alert on s3 object upload"

    event_pattern = jsonencode({
        source = ["aws.s3"]
        detail-type = ["Oject Created"]
        detail ={
            bucket={
                name = [aws_s3_bucket.upload_bucket.id]
            }
        }

    })
}
resource "aws_cloudwatch_event_target" "sns_target"{
    depends_on = [ aws_sns_topic.s3_alerts ]
    target_id = "SendToSNS"
    rule = aws_cloudwatch_event_rule.object_upload.name
    arn = aws_sns_topic.s3_alerts.arn
}
resource "aws_sns_topic_policy" "allow_event_bridge"{
    arn = aws_sns_topic.s3_alerts.arn
    policy = data.aws_iam_policy_document.allow_eventbridge.json
}