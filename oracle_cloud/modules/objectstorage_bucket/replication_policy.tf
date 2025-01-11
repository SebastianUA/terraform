#-----------------------------------------------------------
# replication policy
#-----------------------------------------------------------
resource "oci_objectstorage_replication_policy" "objectstorage_replication_policy" {
  count = var.enable_objectstorage_replication_policy ? 1 : 0

  # Required
  name                    = var.objectstorage_replication_policy_name != "" ? var.objectstorage_replication_policy_name : "${lower(var.name)}-replication-policy-${lower(var.environment)}"
  bucket                  = var.objectstorage_replication_policy_bucket != "" && !var.enable_objectstorage_bucket ? var.objectstorage_replication_policy_bucket : element(oci_objectstorage_bucket.objectstorage_bucket.*.bucket_id, 0)
  namespace               = var.objectstorage_replication_policy_namespace != "" && !var.enable_objectstorage_bucket ? var.objectstorage_replication_policy_namespace : element(oci_objectstorage_bucket.objectstorage_bucket.*.namespace, 0)
  destination_bucket_name = var.objectstorage_replication_policy_destination_bucket_name
  destination_region_name = var.objectstorage_replication_policy_destination_region_name

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.objectstorage_replication_policy_timeouts)) > 0 ? [var.objectstorage_replication_policy_timeouts] : []

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