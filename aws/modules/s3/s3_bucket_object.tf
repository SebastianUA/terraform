
#---------------------------------------------------
# Create S3 bucket
#---------------------------------------------------
resource "aws_s3_bucket_object" "s3_bucket_object" {
    count                           = var.enable_s3_bucket_object ? length(var.s3_bucket_object_source) : 0

    bucket                          = var.s3_bucket_object_bucket != "" && !var.enable_s3_bucket ? var.s3_bucket_object_bucket : element(concat(aws_s3_bucket.s3_bucket.*.id, [""]), 0)
    key                             = var.s3_bucket_object_key != "" ? lower(var.s3_bucket_object_key) : var.s3_bucket_object_source[count.index]
    source                          = var.s3_bucket_object_source[count.index]

    content_type                    = var.s3_bucket_object_content_type != "" ? var.s3_bucket_object_content_type : lookup(var.mime_types, var.type_of_file)
    content                         = var.s3_bucket_object_content != null ? var.s3_bucket_object_content : null
    content_base64                  = var.s3_bucket_object_content_base64 != null ? var.s3_bucket_object_content_base64 : null
    content_disposition             = var.s3_bucket_object_content_disposition != null ? var.s3_bucket_object_content_disposition : null
    content_encoding                = var.s3_bucket_object_content_encoding != null ? var.s3_bucket_object_content_encoding : null
    content_language                = var.s3_bucket_object_content_language != null ? var.s3_bucket_object_content_language : null

    acl                             = var.s3_bucket_object_acl
    cache_control                   = var.s3_bucket_object_cache_control != null ? var.s3_bucket_object_cache_control : null
    website_redirect                = var.s3_bucket_object_website_redirect != null ? var.s3_bucket_object_website_redirect : null
    storage_class                   = upper(var.s3_bucket_object_storage_class)
    etag                            = var.s3_bucket_object_etag != null ? var.s3_bucket_object_etag : null
    metadata                        = var.s3_bucket_object_metadata != null ? var.s3_bucket_object_metadata : null
    force_destroy                   = var.s3_bucket_object_force_destroy

    server_side_encryption          = var.s3_bucket_object_server_side_encryption != null ? var.s3_bucket_object_server_side_encryption : null
    kms_key_id                      = var.s3_bucket_object_kms_key_id != null ? var.s3_bucket_object_kms_key_id : null

    object_lock_legal_hold_status   = var.s3_bucket_object_object_lock_legal_hold_status != null ? upper(var.s3_bucket_object_object_lock_legal_hold_status) : null
    object_lock_mode                = var.s3_bucket_object_object_lock_mode != null ? upper(var.s3_bucket_object_object_lock_mode) : null
    object_lock_retain_until_date   = var.s3_bucket_object_object_lock_retain_until_date != null ? var.s3_bucket_object_object_lock_retain_until_date : null

    tags                            = merge(
        {
            "Name"  = var.s3_bucket_object_key != "" ? lower(var.s3_bucket_object_key) : var.s3_bucket_object_source[count.index]
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                      = [
        aws_s3_bucket.s3_bucket
    ]
}
