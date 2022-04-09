#---------------------------------------------------
# AWS S3 bucket server side encryption configuration
#---------------------------------------------------
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_server_side_encryption_configuration" {
  count = var.enable_s3_bucket_server_side_encryption_configuration ? 1 : 0

  bucket = var.s3_bucket_server_side_encryption_configuration_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_server_side_encryption_configuration_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)

  dynamic "rule" {
    iterator = rule
    for_each = var.s3_bucket_server_side_encryption_configuration_rule

    content {
      dynamic "apply_server_side_encryption_by_default" {
        iterator = apply_server_side_encryption_by_default
        for_each = length(keys(lookup(rule.value, "apply_server_side_encryption_by_default", {}))) > 0 ? [lookup(rule.value, "apply_server_side_encryption_by_default", {})] : []

        content {
          kms_master_key_id = lookup(apply_server_side_encryption_by_default.value, "kms_master_key_id", null)

          sse_algorithm = lookup(apply_server_side_encryption_by_default.value, "sse_algorithm", null)
        }
      }
    }
  }

  expected_bucket_owner = var.s3_bucket_server_side_encryption_configuration_expected_bucket_owner

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}