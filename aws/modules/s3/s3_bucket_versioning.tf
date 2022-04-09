#---------------------------------------------------
# AWS S3 bucket versioning
#---------------------------------------------------
resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  count = var.enable_s3_bucket_versioning ? 1 : 0

  bucket = var.s3_bucket_versioning_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_versioning_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)

  expected_bucket_owner = var.s3_bucket_versioning_expected_bucket_owner
  mfa                   = var.s3_bucket_versioning_mfa

  dynamic "versioning_configuration" {
    iterator = versioning_configuration
    for_each = length(var.s3_bucket_versioning_versioning_configuration) > 0 ? [var.s3_bucket_versioning_versioning_configuration] : []

    content {
      status = lookup(versioning_configuration.value, "status", null)

      mfa_delete = lookup(versioning_configuration.value, "mfa_delete", null)
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