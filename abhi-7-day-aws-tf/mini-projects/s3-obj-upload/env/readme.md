# S3 bucket object upload , with lerts.
1. Create s3 bucket
   - configure bucket access with public block block , bucket acls
2. Create SnS topic
   - allow event bridge to publish message
   - Configure email reciver address to send alerts
3. Configure Event bridge for subject object uploads.

- resources created for this poc:
  1. resource sns_topic
  2. resource sns_topic_subscription
  3. resource aws_s3_bucket
  4. resource aws_s3_bucket_ownership_controls
  5. resource aws_S3_bucket_acl
  6. resource aws_s3_bucket_public_access_block
  7. resource aws_s3_object
  8. resource as_s3_bucket_notification
  9. resource aws_s3_bucket_object
  10. resource aws_cloudwatch_event_rule
  11. resource aws_cloudwatch_event_target
  12. data iam_policy_document
  13. resource aws_sns_topic_policy

# flow of resource
- create snsn topic and subscription to sns via email notification
- create s3 bucket , bucket owner, bucket bucket acl, public access block
- create s3 object upload
- create cloduwatc_event rule, event_target, 
- create iam policy doc to allow event bridge to publish message in sns topic,
    bind it    with aws_sns_topic_policy.