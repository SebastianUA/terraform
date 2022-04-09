#---------------------------------------------------
# AWS S3 account public access block
#---------------------------------------------------
resource "aws_s3_account_public_access_block" "s3_account_public_access_block" {
  count = var.enable_s3_account_public_access_block ? 1 : 0

  account_id              = var.s3_account_public_access_block_account_id
  block_public_acls       = var.s3_account_public_access_block_block_public_acls
  block_public_policy     = var.s3_account_public_access_block_block_public_policy
  ignore_public_acls      = var.s3_account_public_access_block_ignore_public_acls
  restrict_public_buckets = var.s3_account_public_access_block_restrict_public_buckets

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}