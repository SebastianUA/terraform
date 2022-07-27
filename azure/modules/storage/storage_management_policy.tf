#-----------------------------------------------------------
# Azure storage management policy
#-----------------------------------------------------------
resource "azurerm_storage_management_policy" "storage_management_policy" {
  count = var.enable_storage_management_policy ? 1 : 0

  storage_account_id = var.storage_management_policy_storage_account_id != "" ? var.storage_management_policy_storage_account_id : (var.enable_storage_account ? azurerm_storage_account.storage_account[count.index].id : null)

  dynamic "rule" {
    iterator = rule
    for_each = var.storage_management_policy_rule

    content {
      name    = lookup(rule.value, "name", null)
      enabled = lookup(rule.value, "enabled", null)

      dynamic "filters" {
        iterator = filters
        for_each = length(keys(lookup(rule.value, "filters", {}))) > 0 ? [lookup(rule.value, "filters", {})] : []

        content {
          blob_types = lookup(filters.value, "blob_types", null)

          prefix_match = lookup(filters.value, "prefix_match", null)

          dynamic "match_blob_index_tag" {
            iterator = match_blob_index_tag
            for_each = length(keys(lookup(filters.value, "match_blob_index_tag", {}))) > 0 ? [lookup(filters.value, "match_blob_index_tag", {})] : []

            content {
              name      = lookup(match_blob_index_tag.value, "name", null)
              operation = lookup(match_blob_index_tag.value, "operation", null)
              value     = lookup(match_blob_index_tag.value, "value", null)
            }
          }
        }
      }

      dynamic "actions" {
        iterator = actions
        for_each = length(keys(lookup(rule.value, "actions", {}))) > 0 ? [lookup(rule.value, "actions", {})] : []

        content {
          dynamic "base_blob" {
            iterator = base_blob
            for_each = length(keys(lookup(actions.value, "base_blob", {}))) > 0 ? [lookup(actions.value, "base_blob", {})] : []

            content {
              tier_to_cool_after_days_since_modification_greater_than        = lookup(base_blob.value, "tier_to_cool_after_days_since_modification_greater_than", null)
              tier_to_cool_after_days_since_last_access_time_greater_than    = lookup(base_blob.value, "tier_to_cool_after_days_since_last_access_time_greater_than", null)
              tier_to_archive_after_days_since_modification_greater_than     = lookup(base_blob.value, "tier_to_archive_after_days_since_modification_greater_than", null)
              tier_to_archive_after_days_since_last_access_time_greater_than = lookup(base_blob.value, "tier_to_archive_after_days_since_last_access_time_greater_than", null)
              delete_after_days_since_modification_greater_than              = lookup(base_blob.value, "delete_after_days_since_modification_greater_than", null)
              delete_after_days_since_last_access_time_greater_than          = lookup(base_blob.value, "delete_after_days_since_last_access_time_greater_than", null)
            }
          }

          dynamic "snapshot" {
            iterator = snapshot
            for_each = length(keys(lookup(actions.value, "snapshot", {}))) > 0 ? [lookup(actions.value, "snapshot", {})] : []

            content {
              change_tier_to_archive_after_days_since_creation = lookup(snapshot.value, "change_tier_to_archive_after_days_since_creation", null)
              change_tier_to_cool_after_days_since_creation    = lookup(snapshot.value, "change_tier_to_cool_after_days_since_creation", null)
              delete_after_days_since_creation_greater_than    = lookup(snapshot.value, "delete_after_days_since_creation_greater_than", null)
            }
          }


          dynamic "version" {
            iterator = version
            for_each = length(keys(lookup(actions.value, "version", {}))) > 0 ? [lookup(actions.value, "version", {})] : []

            content {
              change_tier_to_archive_after_days_since_creation = lookup(version.value, "change_tier_to_archive_after_days_since_creation", null)
              change_tier_to_cool_after_days_since_creation    = lookup(version.value, "change_tier_to_cool_after_days_since_creation", null)
              delete_after_days_since_creation                 = lookup(version.value, "delete_after_days_since_creations", null)
            }
          }
        }
      }

    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.storage_management_policy_timeouts)) > 0 ? [var.storage_management_policy_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_storage_account.storage_account
  ]
}