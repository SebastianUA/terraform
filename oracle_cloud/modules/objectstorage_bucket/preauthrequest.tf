#-----------------------------------------------------------
# objectstorage preauthrequest
#-----------------------------------------------------------
resource "oci_objectstorage_preauthrequest" "objectstorage_preauthrequest" {
  count = var.enable_objectstorage_preauthrequest ? 1 : 0

  # Required
  bucket       = var.objectstorage_preauthrequest_bucket != "" && !var.enable_objectstorage_bucket ? var.objectstorage_preauthrequest_bucket : element(oci_objectstorage_bucket.objectstorage_bucket.*.bucket_id, 0)
  namespace    = var.objectstorage_preauthrequest_namespace != "" && !var.enable_objectstorage_bucket ? var.objectstorage_preauthrequest_namespace : element(oci_objectstorage_bucket.objectstorage_bucket.*.namespace, 0)
  name         = var.objectstorage_preauthrequest_name != "" ? var.objectstorage_preauthrequest_name : "${lower(var.name)}-objstr-preauthrequest-${lower(var.environment)}"
  access_type  = var.objectstorage_preauthrequest_access_type
  time_expires = var.objectstorage_preauthrequest_time_expires

  # Optional
  bucket_listing_action = var.objectstorage_preauthrequest_bucket_listing_action
  object_name           = var.objectstorage_preauthrequest_object_name

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.objectstorage_preauthrequest_timeouts)) > 0 ? [var.objectstorage_preauthrequest_timeouts] : []

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