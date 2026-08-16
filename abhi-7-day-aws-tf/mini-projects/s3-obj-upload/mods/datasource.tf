
data "aws_iam_policy_document" "allow_eventbridge"{
    statement {
      sid = "AllowEventBridgeToPublish"
      effect = "Allow"
      principals {
        type = "Service"
        identifiers = ["events.amazonaws.com"]
      }
      actions = ["sns:Publish"]
      resources = [aws_sns_topic.s3_alerts.arn]
    }
}
