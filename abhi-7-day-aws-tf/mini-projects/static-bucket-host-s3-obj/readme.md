# Static website hosting with s3

1. Create SNS topic and subscription with email endpoint.
2. Create s3 bucket configure bucket ownership controls, public access blocks and bucket acls, bucket notifications.
3. Create s3 object with source and file.
4. Create eventbridge rule and target, iam policy document to allow event bridge to publish message in sns topic.