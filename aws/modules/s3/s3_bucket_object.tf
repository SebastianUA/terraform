
#---------------------------------------------------
# Create S3 bucket
#---------------------------------------------------
resource "aws_s3_bucket_object" "s3_bucket_object" {
  count = var.enable_s3_bucket_object ? length(var.s3_bucket_object_source) : 0

  bucket = var.s3_bucket_object_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_object_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)
  key    = var.s3_bucket_object_key != "" ? lower(var.s3_bucket_object_key) : var.s3_bucket_object_source[count.index]

  source              = var.s3_bucket_object_source[count.index]
  content_type        = var.s3_bucket_object_content_type
  content             = var.s3_bucket_object_content
  content_base64      = var.s3_bucket_object_content_base64
  content_disposition = var.s3_bucket_object_content_disposition
  content_encoding    = var.s3_bucket_object_content_encoding
  content_language    = var.s3_bucket_object_content_language

  acl              = var.s3_bucket_object_acl
  cache_control    = var.s3_bucket_object_cache_control
  website_redirect = var.s3_bucket_object_website_redirect
  storage_class    = var.s3_bucket_object_storage_class != null ? upper(var.s3_bucket_object_storage_class) : null
  etag             = var.s3_bucket_object_etag
  metadata         = var.s3_bucket_object_metadata
  force_destroy    = var.s3_bucket_object_force_destroy

  server_side_encryption = var.s3_bucket_object_server_side_encryption
  kms_key_id             = var.s3_bucket_object_kms_key_id

  object_lock_legal_hold_status = var.s3_bucket_object_object_lock_legal_hold_status
  object_lock_mode              = var.s3_bucket_object_object_lock_mode != null ? upper(var.s3_bucket_object_object_lock_mode) : null
  object_lock_retain_until_date = var.s3_bucket_object_object_lock_retain_until_date

  tags = merge(
    {
      Name = var.s3_bucket_object_key != "" ? lower(var.s3_bucket_object_key) : var.s3_bucket_object_source[count.index]
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}
