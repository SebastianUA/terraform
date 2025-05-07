#-----------------------------------------------------------
# objectstorage object
#-----------------------------------------------------------
resource "oci_objectstorage_object" "objectstorage_object" {
  count = var.enable_objectstorage_object_timeouts ? 1 : 0

  # Required
  bucket    = var.objectstorage_object_bucket != "" && !var.enable_objectstorage_bucket ? var.objectstorage_object_bucket : element(oci_objectstorage_bucket.objectstorage_bucket.*.bucket_id, 0)
  namespace = var.objectstorage_object_namespace != "" && !var.enable_objectstorage_bucket ? var.objectstorage_object_namespace : element(oci_objectstorage_bucket.objectstorage_bucket.*.namespace, 0)
  object    = var.objectstorage_object_object

  # Optional
  content                    = var.objectstorage_object_content
  cache_control              = var.objectstorage_object_cache_control
  content_disposition        = var.objectstorage_object_content_disposition
  content_encoding           = var.objectstorage_object_content_encoding
  content_language           = var.objectstorage_object_content_language
  content_type               = var.objectstorage_object_content_type
  delete_all_object_versions = var.objectstorage_object_delete_all_object_versions
  metadata                   = var.objectstorage_object_metadata
  storage_tier               = var.objectstorage_object_storage_tier
  opc_sse_kms_key_id         = var.objectstorage_object_opc_sse_kms_key_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.objectstorage_object_timeouts)) > 0 ? [var.objectstorage_object_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}