#---------------------------------------------------
# S3 bucket policy
#---------------------------------------------------
resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  count = var.enable_s3_bucket_policy ? 1 : 0

  bucket = var.s3_bucket_policy_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_policy_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)
  policy = var.s3_bucket_policy_policy

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}