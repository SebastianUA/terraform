#---------------------------------------------------
# AWS S3 bucket inventory
#---------------------------------------------------
resource "aws_s3_bucket_inventory" "s3_bucket_inventory" {
  count = var.enable_s3_bucket_inventory ? 1 : 0

  name                     = var.s3_bucket_inventory_name != "" ? lower(var.s3_bucket_inventory_name) : "${lower(var.name)}-s3-inventory-${lower(var.environment)}"
  bucket                   = var.s3_bucket_inventory_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_inventory_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)
  included_object_versions = var.s3_bucket_inventory_included_object_versions

  enabled         = var.s3_bucket_inventory_enabled
  optional_fields = var.s3_bucket_inventory_optional_fields

  // Required
  dynamic "schedule" {
    iterator = schedule
    for_each = var.s3_bucket_inventory_schedule

    content {
      frequency = lookup(schedule.value, "prefix", null)
    }
  }

  // Required
  dynamic "destination" {
    iterator = destination
    for_each = var.s3_bucket_inventory_destination

    content {
      dynamic "bucket" {
        iterator = bucket
        for_each = length(keys(lookup(destination.value, "bucket", {}))) > 0 ? [lookup(destination.value, "bucket", {})] : []

        content {
          format     = lookup(bucket.value, "format", null)
          bucket_arn = lookup(bucket.value, "bucket_arn", null)
          account_id = lookup(bucket.value, "account_id", null)
          prefix     = lookup(bucket.value, "prefix", null)

          dynamic "encryption" {
            iterator = encryption
            for_each = length(keys(lookup(bucket.value, "encryption", {}))) > 0 ? [lookup(bucket.value, "encryption", {})] : []

            content {
              dynamic "sse_kms" {
                iterator = sse_kms
                for_each = length(keys(lookup(encryption.value, "sse_kms", {}))) > 0 ? [lookup(encryption.value, "sse_kms", {})] : []

                content {
                  key_id = lookup(sse_kms.value, "key_id", null)
                }
              }

              dynamic "sse_s3" {
                iterator = sse_s3
                for_each = length(keys(lookup(encryption.value, "sse_s3", {}))) > 0 ? [lookup(encryption.value, "sse_s3", {})] : []

                content {
                  // key_id = lookup(sse_s3.value, "key_id", null)
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "filter" {
    iterator = filter
    for_each = var.s3_bucket_inventory_filter

    content {
      prefix = lookup(filter.value, "prefix", null)
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