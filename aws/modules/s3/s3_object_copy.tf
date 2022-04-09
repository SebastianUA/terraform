#---------------------------------------------------
# AWS S3 bucket object copy
#---------------------------------------------------
resource "aws_s3_object_copy" "s3_object_copy" {
  count = var.enable_s3_bucket_object_copy ? length(var.s3_bucket_object_copy_stack) : 0

  bucket = lookup(var.s3_bucket_object_copy_stack[count.index], "bucket", (var.enable_s3_bucket ? element(aws_s3_bucket.s3_bucket.*.id, 0) : null))
  key    = lookup(var.s3_bucket_object_copy_stack[count.index], "key", null)
  source = lookup(var.s3_bucket_object_copy_stack[count.index], "source", null)

  acl                           = lookup(var.s3_bucket_object_copy_stack[count.index], "acl", null)
  cache_control                 = lookup(var.s3_bucket_object_copy_stack[count.index], "cache_control", null)
  content_disposition           = lookup(var.s3_bucket_object_copy_stack[count.index], "content_disposition", null)
  content_encoding              = lookup(var.s3_bucket_object_copy_stack[count.index], "content_encoding", null)
  content_language              = lookup(var.s3_bucket_object_copy_stack[count.index], "content_language", null)
  content_type                  = lookup(var.s3_bucket_object_copy_stack[count.index], "content_type", null)
  copy_if_match                 = lookup(var.s3_bucket_object_copy_stack[count.index], "copy_if_match", null)
  copy_if_modified_since        = lookup(var.s3_bucket_object_copy_stack[count.index], "copy_if_modified_since", null)
  copy_if_none_match            = lookup(var.s3_bucket_object_copy_stack[count.index], "copy_if_none_match", null)
  copy_if_unmodified_since      = lookup(var.s3_bucket_object_copy_stack[count.index], "copy_if_unmodified_since", null)
  customer_algorithm            = lookup(var.s3_bucket_object_copy_stack[count.index], "customer_algorithm", null)
  customer_key                  = lookup(var.s3_bucket_object_copy_stack[count.index], "customer_key", null)
  customer_key_md5              = lookup(var.s3_bucket_object_copy_stack[count.index], "customer_key_md5", null)
  expected_bucket_owner         = lookup(var.s3_bucket_object_copy_stack[count.index], "expected_bucket_owner", null)
  expected_source_bucket_owner  = lookup(var.s3_bucket_object_copy_stack[count.index], "expected_source_bucket_owner", null)
  expires                       = lookup(var.s3_bucket_object_copy_stack[count.index], "expires", null)
  force_destroy                 = lookup(var.s3_bucket_object_copy_stack[count.index], "force_destroy", null)
  kms_encryption_context        = lookup(var.s3_bucket_object_copy_stack[count.index], "kms_encryption_context", null)
  kms_key_id                    = lookup(var.s3_bucket_object_copy_stack[count.index], "kms_key_id", null)
  metadata                      = lookup(var.s3_bucket_object_copy_stack[count.index], "metadata", null)
  metadata_directive            = lookup(var.s3_bucket_object_copy_stack[count.index], "metadata_directive", null)
  object_lock_legal_hold_status = lookup(var.s3_bucket_object_copy_stack[count.index], "object_lock_legal_hold_status", null)
  object_lock_mode              = lookup(var.s3_bucket_object_copy_stack[count.index], "object_lock_mode", null)
  object_lock_retain_until_date = lookup(var.s3_bucket_object_copy_stack[count.index], "object_lock_retain_until_date", null)
  request_payer                 = lookup(var.s3_bucket_object_copy_stack[count.index], "request_payer", null)
  server_side_encryption        = lookup(var.s3_bucket_object_copy_stack[count.index], "server_side_encryption", null)
  source_customer_algorithm     = lookup(var.s3_bucket_object_copy_stack[count.index], "source_customer_algorithm", null)
  source_customer_key           = lookup(var.s3_bucket_object_copy_stack[count.index], "source_customer_key", null)
  source_customer_key_md5       = lookup(var.s3_bucket_object_copy_stack[count.index], "source_customer_key_md5", null)
  storage_class                 = lookup(var.s3_bucket_object_copy_stack[count.index], "storage_class", null)
  tagging_directive             = lookup(var.s3_bucket_object_copy_stack[count.index], "tagging_directive", null)
  website_redirect              = lookup(var.s3_bucket_object_copy_stack[count.index], "website_redirect", null)

  dynamic "grant" {
    iterator = grant
    for_each = lookup(var.s3_bucket_object_copy_stack[count.index], "grant", [])

    content {
      type        = lookup(grant.value[count.index], "type", null)
      permissions = lookup(grant.value[count.index], "permissions", null)

      id    = lookup(grant.value[count.index], "id", null)
      uri   = lookup(grant.value[count.index], "uri", null)
      email = lookup(grant.value[count.index], "email", null)
    }
  }

  tags = merge(
    {
      Name = lookup(var.s3_bucket_object_copy_stack[count.index], "key", null)
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
