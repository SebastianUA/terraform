#---------------------------------------------------
# S3 bucket public access block
#---------------------------------------------------
resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_block" {
  count = var.enable_s3_bucket_public_access_block ? 1 : 0

  bucket = var.s3_bucket_public_access_block_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_public_access_block_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)

  block_public_acls       = var.s3_bucket_public_access_block_block_public_acls
  block_public_policy     = var.s3_bucket_public_access_block_block_public_policy
  ignore_public_acls      = var.s3_bucket_public_access_block_ignore_public_acls
  restrict_public_buckets = var.s3_bucket_public_access_block_restrict_public_buckets

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}