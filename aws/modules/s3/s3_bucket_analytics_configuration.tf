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

  dynamic "storage_class_analysis" {
    iterator = storage_class_analysis
    for_each = var.s3_bucket_analytics_configuration_storage_class_analysis

    content {
      dynamic "data_export" {
        iterator = data_export
        for_each = length(keys(lookup(storage_class_analysis.value, "data_export", {}))) > 0 ? [lookup(storage_class_analysis.value, "data_export", {})] : []

        content {
          output_schema_version = lookup(data_export.value, "output_schema_version", null)

          dynamic "destination" {
            iterator = destination
            for_each = length(keys(lookup(data_export.value, "destination", {}))) > 0 ? [lookup(data_export.value, "destination", {})] : []

            content {
              dynamic "s3_bucket_destination" {
                iterator = s3_bucket_destination
                for_each = length(keys(lookup(destination.value, "s3_bucket_destination", {}))) > 0 ? [lookup(destination.value, "s3_bucket_destination", {})] : []

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