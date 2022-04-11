#---------------------------------------------------
# AWS S3 bucket
#---------------------------------------------------
resource "aws_s3_bucket" "s3_bucket" {
  count = var.enable_s3_bucket ? 1 : 0

  bucket        = var.s3_bucket_name != null && var.s3_bucket_prefix == null ? lower(var.s3_bucket_name) : null
  bucket_prefix = var.s3_bucket_prefix != null && var.s3_bucket_name == null ? lower(var.s3_bucket_prefix) : null

  force_destroy       = var.s3_bucket_force_destroy
  object_lock_enabled = var.s3_bucket_object_lock_enabled

  tags = merge(
    {
      Name = var.s3_bucket_name != null && var.s3_bucket_prefix == null ? lower(var.s3_bucket_name) : lower(var.s3_bucket_prefix)
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
