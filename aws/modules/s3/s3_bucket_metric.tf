#---------------------------------------------------
# AWS S3 bucket metric
#---------------------------------------------------
resource "aws_s3_bucket_metric" "s3_bucket_metric" {
  count = var.enable_s3_bucket_metric ? 1 : 0

  name   = var.s3_bucket_metric_name != "" ? lower(var.s3_bucket_metric_name) : "${lower(var.name)}-s3-metric-${lower(var.environment)}"
  bucket = var.s3_bucket_metric_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_metric_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)

  dynamic "filter" {
    iterator = filter
    for_each = var.s3_bucket_metric_filter

    content {
      prefix = lookup(filter.value, "prefix", null)
      tags   = lookup(filter.value, "tags", null)
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