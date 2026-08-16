variable "bucket_name" {
    type = string
    description = "poc bucket name"
}
variable "email"{
    description = "subscriber email to sns topic"
    type = string
}
variable "sns_topic_name"{
    description = "to publish s3 bucket events here"
    type = string
}

