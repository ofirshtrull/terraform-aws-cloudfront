
resource "aws_s3_bucket" "log" {
  count         = var.logging_enabled ? 1 : 0
  bucket        = format("%s-%s-cloudfront-logs", var.env_name, var.name)
  acl           = var.s3_logs_acl
  region        = var.s3_logs_region
  force_destroy = false
  policy        = var.s3_logs_policy

  lifecycle_rule {
    id      = "logs"
    enabled = true
    expiration {
      days = var.log_expiration_days
    }
  }
}

resource "aws_cloudfront_distribution" "main" {
  aliases             = var.aliases
  enabled             = "true"
  http_version        = "http2"
  price_class         = var.price_class
  retain_on_delete    = var.retain_on_delete
  is_ipv6_enabled     = var.ipv6_enabled
  comment             = var.comment
  wait_for_deployment = var.wait_for_deployment

  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.geo_restriction_locations
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = var.acm_certificate_arn == "" ? "" : "sni-only"
    minimum_protocol_version       = var.minimum_protocol_version
    cloudfront_default_certificate = var.acm_certificate_arn == "" ? true : false
  }

  dynamic "logging_config" {
    for_each = var.logging_enabled ? ["true"] : []
    content {
      include_cookies = var.log_include_cookies
      bucket          = aws_s3_bucket.log.0.bucket_domain_name
      prefix          = var.log_prefix
    }
  }


  dynamic "origin" {
    for_each = var.dynamic_s3_origin_config
    content {
      domain_name = lookup(origin.value, "domain_name", null)
      origin_id   = lookup(origin.value, "origin_id", null)
      origin_path = lookup(origin.value, "origin_path", null)
    }
  }

  dynamic "origin" {
    for_each = var.dynamic_custom_origin_config
    content {
      domain_name = lookup(origin.value, "domain_name", null)
      origin_id   = lookup(origin.value, "origin_id", null)
      origin_path = lookup(origin.value, "origin_path", null)
      custom_origin_config {
        http_port                = lookup(origin.value, "http_port", null)
        https_port               = lookup(origin.value, "https_port", null)
        origin_keepalive_timeout = lookup(origin.value, "origin_keepalive_timeout", null)
        origin_read_timeout      = lookup(origin.value, "origin_read_timeout", null)
        origin_protocol_policy   = lookup(origin.value, "origin_protocol_policy", null)
        origin_ssl_protocols     = lookup(origin.value, "origin_ssl_protocols", null)
      }
    }
  }

  dynamic "default_cache_behavior" {
    for_each = var.dynamic_default_cache_behavior
    content {
      allowed_methods  = lookup(default_cache_behavior.value, "allowed_methods", null)
      cached_methods   = lookup(default_cache_behavior.value, "cached_methods", null)
      target_origin_id = lookup(default_cache_behavior.value, "target_origin_id", null)
      compress         = lookup(default_cache_behavior.value, "compress", null)

      forwarded_values {
        query_string = lookup(default_cache_behavior.value, "query_string", null)
        cookies {
          forward = lookup(default_cache_behavior.value, "cookies_forward", null)
        }
        headers = lookup(default_cache_behavior.value, "headers", null)
      }
      viewer_protocol_policy = lookup(default_cache_behavior.value, "viewer_protocol_policy", null)
      min_ttl                = lookup(default_cache_behavior.value, "min_ttl", null)
      default_ttl            = lookup(default_cache_behavior.value, "default_ttl", null)
      max_ttl                = lookup(default_cache_behavior.value, "max_ttl", null)
    }
  }

  dynamic "ordered_cache_behavior" {
    for_each = var.dynamic_ordered_cache_behavior
    content {
      path_pattern     = lookup(ordered_cache_behavior.value, "path_pattern", null)
      allowed_methods  = lookup(ordered_cache_behavior.value, "allowed_methods", null)
      cached_methods   = lookup(ordered_cache_behavior.value, "cached_methods", null)
      target_origin_id = lookup(ordered_cache_behavior.value, "target_origin_id", null)
      compress         = lookup(ordered_cache_behavior.value, "compress", null)

      forwarded_values {
        query_string = lookup(ordered_cache_behavior.value, "query_string", null)
        cookies {
          forward = lookup(ordered_cache_behavior.value, "cookies_forward", null)
        }
        headers = lookup(ordered_cache_behavior.value, "headers", null)
      }
      viewer_protocol_policy = lookup(ordered_cache_behavior.value, "viewer_protocol_policy", null)
      min_ttl                = lookup(ordered_cache_behavior.value, "min_ttl", null)
      default_ttl            = lookup(ordered_cache_behavior.value, "default_ttl", null)
      max_ttl                = lookup(ordered_cache_behavior.value, "max_ttl", null)
    }
  }
}
