#-----------------------------------------------------------
# objectstorage bucket
#-----------------------------------------------------------
resource "oci_objectstorage_bucket" "objectstorage_bucket" {
  count = var.enable_objectstorage_bucket ? 1 : 0

  # Required
  name           = var.objectstorage_bucket_name != "" ? var.objectstorage_bucket_name : "${lower(var.name)}-objstr-bucket-${lower(var.environment)}"
  namespace      = var.objectstorage_bucket_namespace
  compartment_id = var.objectstorage_bucket_compartment_id

  # Optional
  access_type  = var.objectstorage_bucket_access_type
  auto_tiering = var.objectstorage_bucket_auto_tiering

  kms_key_id            = var.objectstorage_bucket_kms_key_id
  metadata              = var.objectstorage_bucket_metadata
  object_events_enabled = var.objectstorage_bucket_object_events_enabled
  storage_tier          = var.objectstorage_bucket_storage_tier

  versioning = var.objectstorage_bucket_versioning

  dynamic "retention_rules" {
    iterator = "retention_rules"
    for_each = var.objectstorage_bucket_retention_rules

    content {
      display_name = lookup(retention_rules.value, "time_rule_locked", "rule-${retention_rules.key}")

      dynamic "duration" {
        iterator = "duration"
        for_each = length(keys(lookup(retention_rules.value, "duration", {}))) > 0 ? [lookup(retention_rules.value, "duration", {})] : []

        content {
          time_amount = lookup(duration.value, "time_amount", null)
          time_unit   = lookup(duration.value, "time_unit", null)
        }
      }

      time_rule_locked = lookup(retention_rules.value, "time_rule_locked", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.objectstorage_bucket_timeouts)) > 0 ? [var.objectstorage_bucket_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  defined_tags = var.objectstorage_bucket_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.objectstorage_bucket_name != "" ? var.objectstorage_bucket_name : "${lower(var.name)}-obj-bucket-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
