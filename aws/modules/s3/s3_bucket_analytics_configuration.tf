#---------------------------------------------------
# AWS S3 bucket analytics configuration
#---------------------------------------------------
resource "aws_s3_bucket_analytics_configuration" "s3_bucket_analytics_configuration" {
  count = var.enable_s3_bucket_analytics_configuration ? 1 : 0

  name   = var.s3_bucket_analytics_configuration_name != "" ? lower(var.s3_bucket_analytics_configuration_name) : "${lower(var.name)}-s3-bucket-analytics-configuration-${lower(var.environment)}"
  bucket = var.s3_bucket_analytics_configuration_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_analytics_configuration_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)

  dynamic "filter" {
    iterator = filter
    for_each = var.s3_bucket_analytics_configuration_filter

    content {
      prefix = lookup(filter.value, "prefix", null)
      tags   = lookup(filter.value, "tags", null)
    }
  }

  storage_class_analysis {
    data_export {
      output_schema_version = null

      destination {
        dynamic "s3_bucket_destination" {
          iterator = s3_bucket_destination
          for_each = var.s3_bucket_analytics_configuration_destination_s3_bucket_destination

          content {
            bucket_arn = lookup(s3_bucket_destination.value, "bucket_arn", null)

            bucket_account_id = lookup(s3_bucket_destination.value, "bucket_account_id", null)
            format            = lookup(s3_bucket_destination.value, "format", null)
            prefix            = lookup(s3_bucket_destination.value, "prefix", null)
          }
        }
      }
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
