output "bucket_name" {
    value = module.website.bucket_name
}
output "oac_rul"{
    value = module.website.oac_url
}
output "bucket_ojects"{
    value = module.website.bucket_objects
}
output "eventbridge_alerts"{
    value = module.website.eventbridge_alerts
}