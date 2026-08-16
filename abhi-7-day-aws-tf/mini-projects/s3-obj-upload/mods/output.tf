output "bucket_name" {
    value = aws_s3_bucket.upload_bucket.id 
}
output "s3_bucket_object"{
    value = aws_s3_object.local_upload.content_type
}
output "sns_endpoint"{
    value = aws_sns_topic_subscription.email_subscription
}