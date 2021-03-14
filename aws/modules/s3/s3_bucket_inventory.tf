#---------------------------------------------------
# AWS S3 bucket inventory
#---------------------------------------------------
resource "aws_s3_bucket_inventory" "s3_bucket_inventory" {
  count = var.enable_s3_bucket_inventory ? 1 : 0

  name                     = var.s3_bucket_inventory_name != "" ? lower(var.s3_bucket_inventory_name) : "${lower(var.name)}-s3-inventory-${lower(var.environment)}"
  bucket                   = var.s3_bucket_inventory_bucket != "" && ! var.enable_s3_bucket ? var.s3_bucket_inventory_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)
  included_object_versions = var.s3_bucket_inventory_included_object_versions

  dynamic "schedule" {
    iterator = schedule
    for_each = var.s3_bucket_inventory_schedule
    content {
      frequency = lookup(schedule.value, "prefix", null)
    }
  }

  destination {
    dynamic "bucket" {
      iterator = bucket
      for_each = var.s3_bucket_inventory_destination_bucket
      content {
        format     = lookup(bucket.value, "format", null)
        bucket_arn = lookup(bucket.value, "bucket_arn", null)
        account_id = lookup(bucket.value, "account_id", null)
        prefix     = lookup(bucket.value, "prefix", null)

        encryption {
          sse_kms {
            key_id = lookup(bucket.value, "sse_kms_key_id", null)
          }
          // sse_s3 {
          //   key_id = lookup(bucket.value, "sse_s3_key_id", null)
          // }
        }
      }
    }
  }

  enabled         = var.s3_bucket_inventory_enabled
  optional_fields = var.s3_bucket_inventory_optional_fields

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
