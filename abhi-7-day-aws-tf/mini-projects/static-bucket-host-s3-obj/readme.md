# Static website hosting with s3

1. Create SNS topic and subscription with email endpoint.
2. Create s3 bucket configure bucket ownership controls, public access blocks and bucket acls, bucket notifications.
3. Create s3 object with source and file.
4. Create eventbridge rule and target, iam policy document to allow event bridge to publish message in sns topic.

 - since the bucket ia sprivate , place a cloudfront to host static website in 2 regions with event bridge and sns topic to publish message.

- resource flow:
  1. Creating sns topic and sns topic subscription to publish message on email.
  2. Create s3 bucket, owner controls, bucket access, acl, bucket versioning.
  3. Create s3 bucket notification with sns topic policy
     - for this create iam doc policy to allow event bridge to publish sns topic
     - refer sns topic arn in topic{}, and add dependency of sns topic policy.
  4. create s3 object with key as *.html
  5. create cloudwatch rule, and event pattern for it
  6. create iam policy doc for cloudwatch.
  7. create cloudwatch distribution with ttl, caches, s3 origin, certificate, regions.
  8. create origin access control with s3 origin bucket.