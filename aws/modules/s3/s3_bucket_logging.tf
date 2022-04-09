#---------------------------------------------------
# AWS S3 bucket logging
#---------------------------------------------------
resource "aws_s3_bucket_logging" "s3_bucket_logging" {
  count = var.enable_s3_bucket_logging ? 1 : 0

  bucket        = var.s3_bucket_logging_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_logging_bucket : element(concat(aws_s3_bucket.s3_bucket.*.bucket, [""]), 0)
  target_bucket = var.s3_bucket_logging_target_bucket
  target_prefix = var.s3_bucket_logging_target_prefix

  expected_bucket_owner = var.s3_bucket_logging_expected_bucket_owner

  dynamic "target_grant" {
    iterator = target_grant
    for_each = var.s3_bucket_logging_target_grant

    content {
      permission = lookup(target_grant.value, "permission", null)

      dynamic "grantee" {
        iterator = grantee
        for_each = length(keys(lookup(target_grant.value, "grantee", {}))) > 0 ? [lookup(target_grant.value, "grantee", {})] : []

        content {
          type = lookup(grantee.value, "type", null)

          id            = lookup(grantee.value, "id", null)
          email_address = lookup(grantee.value, "email_address", null)
          uri           = lookup(grantee.value, "uri", null)
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