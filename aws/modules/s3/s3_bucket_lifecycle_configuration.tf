#---------------------------------------------------
# S3 bucket lifecycle configuration
#---------------------------------------------------
resource "aws_s3_bucket_lifecycle_configuration" "s3_bucket_lifecycle_configuration" {
  count = var.enable_s3_bucket_lifecycle_configuration ? 1 : 0

  bucket = var.s3_bucket_lifecycle_configuration_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_lifecycle_configuration_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)

  dynamic "rule" {
    iterator = rule
    for_each = var.s3_bucket_lifecycle_configuration_rule

    content {
      id     = lookup(rule.value, "id", null)
      status = lookup(rule.value, "status", null)

      dynamic "abort_incomplete_multipart_upload" {
        iterator = abort_incomplete_multipart_upload
        for_each = length(keys(lookup(rule.value, "abort_incomplete_multipart_upload", {}))) > 0 ? [lookup(rule.value, "abort_incomplete_multipart_upload", {})] : []

        content {
          days_after_initiation = lookup(abort_incomplete_multipart_upload.value, "days_after_initiation", null)
        }
      }

      dynamic "expiration" {
        iterator = expiration
        for_each = length(keys(lookup(rule.value, "expiration", {}))) > 0 ? [lookup(rule.value, "expiration", {})] : []

        content {
          date                         = lookup(expiration.value, "date", null)
          days                         = lookup(expiration.value, "days", null)
          expired_object_delete_marker = lookup(expiration.value, "expired_object_delete_marker", null)
        }
      }

      dynamic "filter" {
        iterator = filter
        for_each = length(keys(lookup(rule.value, "filter", {}))) > 0 ? [lookup(rule.value, "filter", {})] : []

        content {
          dynamic "and" {
            iterator = and
            for_each = lookup(filter.value, "and", [])

            content {
              object_size_greater_than = lookup(and.value, "object_size_greater_than", null)
              object_size_less_than    = lookup(and.value, "object_size_less_than", null)
              prefix                   = lookup(and.value, "prefix", null)
              tags                     = lookup(and.value, "tags", null)
            }
          }
          object_size_greater_than = lookup(filter.value, "object_size_greater_than", null)
          object_size_less_than    = lookup(filter.value, "object_size_less_than", null)
          prefix                   = lookup(filter.value, "prefix", null)

          dynamic "tag" {
            iterator = tag
            for_each = lookup(filter.value, "tag", {})

            content {
              key   = lookup(tag.value, "key", null)
              value = lookup(tag.value, "value", null)
            }
          }
        }
      }

      dynamic "noncurrent_version_expiration" {
        iterator = noncurrent_version_expiration
        for_each = length(keys(lookup(rule.value, "noncurrent_version_expiration", {}))) > 0 ? [lookup(rule.value, "noncurrent_version_expiration", {})] : []

        content {
          newer_noncurrent_versions = lookup(noncurrent_version_expiration.value, "newer_noncurrent_versions", null)
          noncurrent_days           = lookup(noncurrent_version_expiration.value, "noncurrent_days", null)
        }
      }

      dynamic "noncurrent_version_transition" {
        iterator = noncurrent_version_transition
        for_each = lookup(rule.value, "noncurrent_version_transition", [])

        content {
          newer_noncurrent_versions = lookup(noncurrent_version_transition.value, "newer_noncurrent_versions", null)
          noncurrent_days           = lookup(noncurrent_version_transition.value, "noncurrent_days", null)
          storage_class             = lookup(noncurrent_version_transition.value, "storage_class", null)
        }
      }

      dynamic "transition" {
        iterator = transition
        for_each = lookup(rule.value, "transition", [])

        content {
          date          = lookup(transition.value, "date", null)
          days          = lookup(transition.value, "days", null)
          storage_class = lookup(transition.value, "storage_class", null)
        }
      }
    }
  }

  expected_bucket_owner = var.s3_bucket_lifecycle_configuration_expected_bucket_owner

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}