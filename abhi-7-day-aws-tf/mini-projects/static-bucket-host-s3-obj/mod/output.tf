output "bucket_name" {
    value = aws_s3_bucket.website_bucket.id
}
output "oac_url"{
    value = aws_cloudfront_distribution.website_bucket.domain_name
}
output "bucket_objects"{
    value = aws_s3_object.website_bucket.content
}
output "eventbridge_alerts"{
    value = aws_sns_topic_subscription.email_alert.endpoint_auto_confirms
}