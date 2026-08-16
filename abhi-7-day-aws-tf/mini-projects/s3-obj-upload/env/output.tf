output "bucket_name"{
    value = module.object-upload.bucket_name
}
output "sns_endpoint"{
    value =  module.object-upload.sns_endpoint
}
output "objec_type"{
    value = module.object-upload.s3_bucket_object
}