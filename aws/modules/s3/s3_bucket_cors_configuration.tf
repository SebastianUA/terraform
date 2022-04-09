#---------------------------------------------------
# AWS S3 bucket cors configuration
#---------------------------------------------------
resource "aws_s3_bucket_cors_configuration" "s3_bucket_cors_configuration" {
  count = var.enable_s3_bucket_cors_configuration ? 1 : 0

  bucket                = var.s3_bucket_cors_configuration_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_cors_configuration_bucket : element(concat(aws_s3_bucket.s3_bucket.*.bucket, [""]), 0)
  expected_bucket_owner = var.s3_bucket_cors_configuration_expected_bucket_owner

  dynamic "cors_rule" {
    iterator = cors_rule
    for_each = var.s3_bucket_cors_configuration_cors_rule

    content {
      allowed_methods = lookup(cors_rule.value, "allowed_methods", null)
      allowed_origins = lookup(cors_rule.value, "allowed_origins", null)

      id              = lookup(cors_rule.value, "id", null)
      allowed_headers = lookup(cors_rule.value, "allowed_headers", null)
      expose_headers  = lookup(cors_rule.value, "expose_headers", null)
      max_age_seconds = lookup(cors_rule.value, "max_age_seconds", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}
