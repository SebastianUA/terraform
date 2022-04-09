#---------------------------------------------------
# AWS S3 bucket object
#---------------------------------------------------
resource "aws_s3_object" "s3_object" {
  count = var.enable_s3_object ? length(var.s3_object_stack) : 0

  bucket = lookup(var.s3_object_stack[count.index], "bucket", (var.enable_s3_bucket ? element(aws_s3_bucket.s3_bucket.*.id, 0) : null))
  key    = lookup(var.s3_object_stack[count.index], "key", null)

  source              = lookup(var.s3_object_stack[count.index], "source", null)
  content_type        = lookup(var.s3_object_stack[count.index], "content_type", null)
  content             = lookup(var.s3_object_stack[count.index], "content", null)
  content_base64      = lookup(var.s3_object_stack[count.index], "content_base64", null)
  content_disposition = lookup(var.s3_object_stack[count.index], "content_disposition", null)
  content_encoding    = lookup(var.s3_object_stack[count.index], "content_encoding", null)
  content_language    = lookup(var.s3_object_stack[count.index], "content_language", null)

  acl              = lookup(var.s3_object_stack[count.index], "acl", null)
  cache_control    = lookup(var.s3_object_stack[count.index], "cache_control", null)
  website_redirect = lookup(var.s3_object_stack[count.index], "website_redirect", null)
  storage_class    = lookup(var.s3_object_stack[count.index], "storage_class", null)
  etag             = lookup(var.s3_object_stack[count.index], "etag", null)
  metadata         = lookup(var.s3_object_stack[count.index], "metadata", null)
  force_destroy    = lookup(var.s3_object_stack[count.index], "force_destroy", null)

  server_side_encryption = lookup(var.s3_object_stack[count.index], "server_side_encryption", null)
  kms_key_id             = lookup(var.s3_object_stack[count.index], "kms_key_id", null)

  object_lock_legal_hold_status = lookup(var.s3_object_stack[count.index], "object_lock_legal_hold_status", null)
  object_lock_mode              = lookup(var.s3_object_stack[count.index], "object_lock_mode", null)
  object_lock_retain_until_date = lookup(var.s3_object_stack[count.index], "object_lock_retain_until_date", null)

  tags = merge(
    {
      Name = lookup(var.s3_object_stack[count.index], "key", null)
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