
output "cloudfront_id" {
  value       = aws_cloudfront_distribution.main.id
  description = "ID of AWS CloudFront distribution"
}

output "cloudfront_arn" {
  value       = aws_cloudfront_distribution.main.arn
  description = "ARN of AWS CloudFront distribution"
}

output "cloudfront_status" {
  value       = aws_cloudfront_distribution.main.status
  description = "Current status of the distribution"
}

output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.main.domain_name
  description = "Domain name corresponding to the distribution"
}

output "cloudfront_etag" {
  value       = aws_cloudfront_distribution.main.etag
  description = "Current version of the distribution's information"
}

output "cloudfront_hosted_zone_id" {
  value       = aws_cloudfront_distribution.main.hosted_zone_id
  description = "CloudFront Route 53 zone ID"
}

output "cloudfront_viewer_certificate" {
  value       = aws_cloudfront_distribution.main.viewer_certificate
  description = "CloudFront viewer certificate of the distribution"
}
