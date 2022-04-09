#---------------------------------------------------
# AWS S3 bucket request payment configuration
#---------------------------------------------------
resource "aws_s3_bucket_request_payment_configuration" "s3_bucket_request_payment_configuration" {
  count = var.enable_s3_bucket_request_payment_configuration ? 1 : 0

  bucket = var.s3_bucket_request_payment_configuration_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_request_payment_configuration_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)
  payer  = var.s3_bucket_request_payment_configuration_payer

  expected_bucket_owner = var.s3_bucket_request_payment_configuration_expected_bucket_owner

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}