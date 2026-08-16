 variable "topic_name"{
    description = "sns topic name for bucket uploads alerts"
    type = string
}

variable "topic_endpoint"{
    description = "snsntopic enpoint to send alerts"
    type = string
}

variable "bucket_name"{
    description = "bucket name for object uploads to s3"
    type = string
}
variable "versioning" {
    description = "bucket versiong status for the website bucket"
    type = string
}
variable "event_rule_name"{
    description = "cloudwatch event rule name for object upload"
    type = string
}

