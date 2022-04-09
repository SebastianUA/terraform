#---------------------------------------------------
# S3 bucket object lock configuration
#---------------------------------------------------
resource "aws_s3_bucket_object_lock_configuration" "s3_bucket_object_lock_configuration" {
  count = var.enable_s3_bucket_object_lock_configuration ? 1 : 0

  bucket = var.s3_bucket_object_lock_configuration_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_object_lock_configuration_bucket : element(concat(aws_s3_bucket.s3_bucket.*.bucket, [""]), 0)

  dynamic "rule" {
    iterator = rule
    for_each = var.s3_bucket_object_lock_configuration_rule

    content {
      dynamic "default_retention" {
        iterator = default_retention
        for_each = length(keys(lookup(rule.value, "default_retention", {}))) > 0 ? [lookup(rule.value, "default_retention", {})] : []

        content {
          mode = lookup(default_retention.value, "mode", null)

          days  = lookup(default_retention.value, "days", null)
          years = lookup(default_retention.value, "years", null)
        }
      }

    }
  }

  expected_bucket_owner = var.s3_bucket_object_lock_configuration_expected_bucket_owner
  object_lock_enabled   = var.s3_bucket_object_lock_configuration_object_lock_enabled
  token                 = var.s3_bucket_object_lock_configuration_token

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}
