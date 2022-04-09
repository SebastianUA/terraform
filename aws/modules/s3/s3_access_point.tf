#---------------------------------------------------
# AWS S3 access point
#---------------------------------------------------
resource "aws_s3_access_point" "s3_access_point" {
  count = var.enable_s3_access_point ? 1 : 0

  name   = var.s3_access_point_name != "" ? lower(var.s3_access_point_name) : "${lower(var.name)}-s3-access-point-${lower(var.environment)}"
  bucket = var.s3_access_point_bucket != "" && !var.enable_s3_bucket ? var.s3_access_point_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)

  account_id = var.s3_access_point_account_id
  policy     = var.s3_access_point_policy

  dynamic "public_access_block_configuration" {
    iterator = public_access_block_configuration
    for_each = length(var.s3_access_point_public_access_block_configuration) > 0 ? [var.s3_access_point_public_access_block_configuration] : []

    content {
      block_public_acls       = lookup(public_access_block_configuration.value, "block_public_acls", null)
      block_public_policy     = lookup(public_access_block_configuration.value, "block_public_policy", null)
      ignore_public_acls      = lookup(public_access_block_configuration.value, "ignore_public_acls", null)
      restrict_public_buckets = lookup(public_access_block_configuration.value, "restrict_public_buckets", null)
    }
  }

  dynamic "vpc_configuration" {
    iterator = vpc_configuration
    for_each = var.s3_access_point_vpc_configuration

    content {
      vpc_id = lookup(vpc_configuration.value, "vpc_id", null)
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