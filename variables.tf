
variable "aliases" {
  type        = list(string)
  description = "List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront."
  default     = []
}
variable "name" {
  type        = string
  description = "Name of the deploy(e.g. main or app)"
}
variable "env_name" {
  type        = string
  description = "The name of the env"
}

variable "price_class" {
  type        = string
  default     = "PriceClass_100"
  description = "Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100`"
}
variable "geo_restriction_type" {
  type        = string
  default     = "none"
  description = "Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist`"
}
variable "geo_restriction_locations" {
  type        = list(string)
  default     = []
  description = "List of country codes for which  CloudFront either to distribute content (whitelist) or not distribute your content (blacklist)"
}
variable "retain_on_delete" {
  type        = bool
  description = "(Optional) - Disables the distribution instead of deleting it when destroying the resource through Terraform"
  default     = false
}
variable "acm_certificate_arn" {
  type        = string
  description = "Existing ACM Certificate ARN"
  default     = ""
}
variable "minimum_protocol_version" {
  type        = string
  description = "Cloudfront TLS minimum protocol version"
  default     = "TLSv1.1"
}
variable "log_prefix" {
  type        = string
  default     = ""
  description = "Path of logs in S3 bucket"
}
variable "logging_enabled" {
  type        = bool
  default     = true
  description = "When true, access logs will be sent to a newly created s3 bucket"
}
variable "log_include_cookies" {
  type        = bool
  default     = false
  description = "Include cookies in access logs"
}
variable "s3_logs_acl" {
  type        = string
  description = "The canned ACL to apply. We recommend log-delivery-write for compatibility with AWS services"
  default     = "log-delivery-write"
}
variable "s3_logs_region" {
  type        = string
  description = "If specified, the AWS region this bucket should reside in. Otherwise, the region used by the callee"
  default     = ""
}
variable "s3_logs_policy" {
  type        = string
  description = "A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy"
  default     = ""
}
variable "log_expiration_days" {
  type        = number
  description = "Number of days after which to expunge the objects"
  default     = 90
}
variable "ipv6_enabled" {
  type        = bool
  default     = true
  description = "Set to true to enable an AAAA DNS record to be set as well as the A record"
}
variable "comment" {
  description = "Any comment about the CloudFront Distribution"
  type        = string
  default     = "Built by Terraform"
}
variable "wait_for_deployment" {
  description = "If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this tofalse will skip the process."
  type        = bool
  default     = true
}
variable "dynamic_s3_origin_config" {
  description = "Configuration for the s3 origin config to be used in dynamic block"
  type        = list(map(string))
  default     = []
}
variable "dynamic_custom_origin_config" {
  description = "Configuration for the custom origin config to be used in dynamic block"
  type        = any
  default     = []
}
variable "dynamic_default_cache_behavior" {
  description = "Default Cache Behviors to be used in dynamic block"
  type        = any
}
variable "dynamic_ordered_cache_behavior" {
  description = "Ordered Cache Behaviors to be used in dynamic block"
  type        = any
  default     = []
}
