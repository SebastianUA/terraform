#---------------------------------------------------
# AWS S3 bucket ownership controls 
#---------------------------------------------------
resource "aws_s3_bucket_ownership_controls" "s3_bucket_ownership_controls" {
  count = var.enable_s3_bucket_ownership_controls ? 1 : 0

  bucket = var.s3_bucket_ownership_controls_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_ownership_controls_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)

  dynamic "rule" {
    iterator = rule
    for_each = var.s3_bucket_ownership_controls_rule

    content {
      object_ownership = lookup(rule.value, "object_ownership", null)
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