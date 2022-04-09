#---------------------------------------------------
# AWS S3 bucket intelligent tiering configuration
#---------------------------------------------------
resource "aws_s3_bucket_intelligent_tiering_configuration" "s3_bucket_intelligent_tiering_configuration" {
  count = var.enable_s3_bucket_intelligent_tiering_configuration ? 1 : 0

  bucket = var.s3_bucket_intelligent_tiering_configuration_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_intelligent_tiering_configuration_bucket : element(concat(aws_s3_bucket.s3_bucket.*.bucket, [""]), 0)
  name   = var.s3_bucket_intelligent_tiering_configuration_name != "" ? lower(var.s3_bucket_intelligent_tiering_configuration_name) : "${lower(var.name)}-s3-bucket-intelligent-tiering-conf-${lower(var.environment)}"

  status = var.s3_bucket_intelligent_tiering_configuration_status

  dynamic "filter" {
    iterator = filter
    for_each = var.s3_bucket_intelligent_tiering_configuration_filter

    content {
      prefix = lookup(filter.value, "prefix", null)

      tags = lookup(filter.value, "tags", null)
    }
  }

  dynamic "tiering" {
    iterator = tiering
    for_each = var.s3_bucket_intelligent_tiering_configuration_tiering

    content {
      access_tier = lookup(tiering.value, "access_tier", null)

      days = lookup(tiering.value, "days", null)
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