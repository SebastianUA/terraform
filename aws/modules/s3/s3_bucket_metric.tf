#---------------------------------------------------
# Create S3 bucket metric
#---------------------------------------------------
resource "aws_s3_bucket_metric" "s3_bucket_metric" {
  count = var.enable_s3_bucket_metric ? 1 : 0

  bucket = var.s3_bucket_metric_bucket != null && ! var.enable_s3_bucket ? var.s3_bucket_metric_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)
  name   = var.s3_bucket_metric_name != "" ? lower(var.s3_bucket_metric_name) : "${lower(var.name)}-s3_metric-${lower(var.environment)}"

  dynamic "filter" {
    for_each = var.s3_bucket_metric_filter
    content {
      prefix = lookup(s3_bucket_metric_filter.value, "prefix", null)
      tags = {
        priority = lookup(s3_bucket_metric_filter.value, "priority", null)
        class    = lookup(s3_bucket_metric_filter.value, "class", null)
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
