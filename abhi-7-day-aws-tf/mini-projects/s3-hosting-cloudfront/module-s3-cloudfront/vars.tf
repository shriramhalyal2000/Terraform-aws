variable "bucket_name" {
  type        = string
  description = "origin bucket name for cloudfront distribution"
}
variable "force_destroy" {
  type        = bool
  description = "force destroy option for s3 bucket in cl;oud front distribution"
}
variable "versioning_status" {
  type        = string
  description = "versiong resource status for selected bucket"
}
variable "origin_access_name"{
    type = string
    description = "origin access control name for cloudfront distributions"
}
variable cloudfront_status{
    description =" cloudfront status  "
    type = bool
}
variable "ipv6_status"{
    description = "ipv6 traffic for cloudfront distribution"
    type = bool
}
variable "allowed_methods"{
    description = "what http methods to access the content by user"
    type = list(string)
}
variable "cached_methods"{
    description = "for what http methods does cloudfront allowed to cace and serve content"
    type = list(string)
}
variable "forward_query_string"{
    description = "cloudfront query string forward enabled or not"
    type = bool
}
variable "cookie_forward"{
    description = "cookie forward in values from cloudfront"
    type = string
}
variable "min_ttl"{
    description = "min time to live of caches content in distribution chanels of cloudfront"
    type = number
}
variable "default_ttl" {
    description = "default ttl for cached content"
    type = number
}
variable "max_ttl"{
    description = "max time to live for cached content in cloudfront distribution"
    type = number
}
variable "geo_restriction_type"{
    description = "az perticular region or az in aws to be black listed or restricted to accees by users"
    type = string
}
variable "cloudfront_default_certificate"{
    description = "default sertificate to serve to https from cloudfront distribution"
    type = bool
}