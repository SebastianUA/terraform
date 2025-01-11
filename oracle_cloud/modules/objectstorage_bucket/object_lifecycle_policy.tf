#-----------------------------------------------------------
# objectstorage object lifecycle policy
#-----------------------------------------------------------
resource "oci_objectstorage_object_lifecycle_policy" "objectstorage_object_lifecycle_policy" {
  count = var.enable_objectstorage_object_lifecycle_policy ? 1 : 0

  # Required
  bucket    = var.objectstorage_object_lifecycle_policy_bucket != "" && !var.enable_objectstorage_bucket ? var.objectstorage_object_lifecycle_policy_bucket : element(oci_objectstorage_bucket.objectstorage_bucket.*.bucket_id, 0)
  namespace = var.objectstorage_object_lifecycle_policy_namespace != "" && !var.enable_objectstorage_bucket ? var.objectstorage_object_lifecycle_policy_namespace : element(oci_objectstorage_bucket.objectstorage_bucket.*.namespace, 0)

  # Optional
  dynamic "rules" {
    iterator = "rules"
    for_each = var.objectstorage_object_lifecycle_policy_rules

    content {
      # Required
      action      = lookup(rules.value, "action", null)
      is_enabled  = lookup(rules.value, "is_enabled", null)
      name        = lookup(rules.value, "name", null)
      time_amount = lookup(rules.value, "time_amount", null)
      time_unit   = lookup(rules.value, "time_unit", null)

      # Optional
      dynamic "object_name_filter" {
        iterator = "object_name_filter"
        for_each = length(keys(lookup(rules.value, "object_name_filter", {}))) > 0 ? [lookup(rules.value, "object_name_filter", {})] : []

        content {
          # Optional
          exclusion_patterns = lookup(object_name_filter.value, "exclusion_patterns", null)
          inclusion_patterns = lookup(object_name_filter.value, "exclusion_patterns", null)
          inclusion_prefixes = lookup(object_name_filter.value, "exclusion_patterns", null)
        }
      }
      target = lookup(rules.value, "target", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.objectstorage_object_lifecycle_policy_timeouts)) > 0 ? [var.objectstorage_object_lifecycle_policy_timeouts] : []

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