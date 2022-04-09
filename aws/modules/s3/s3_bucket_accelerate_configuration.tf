#---------------------------------------------------
# AWS S3 bucket accelerate configuration
#---------------------------------------------------
resource "aws_s3_bucket_accelerate_configuration" "s3_bucket_accelerate_configuration" {
  count = var.enable_s3_bucket_accelerate_configuration ? 1 : 0

  bucket = var.s3_bucket_accelerate_configuration_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_accelerate_configuration_bucket : element(concat(aws_s3_bucket.s3_bucket.*.bucket, [""]), 0)
  status = var.s3_bucket_accelerate_configuration_status

  expected_bucket_owner = var.s3_bucket_accelerate_configuration_expected_bucket_owner

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}