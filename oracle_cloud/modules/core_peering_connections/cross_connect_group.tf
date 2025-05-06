#-----------------------------------------------------------
# core cross connect group
#-----------------------------------------------------------
resource "oci_core_cross_connect_group" "core_cross_connect_group" {
  count = var.enable_core_cross_connect_group ? 1 : 0

  # Required
  compartment_id = var.compartment_id

  # Optional
  customer_reference_name = var.core_cross_connect_group_customer_reference_name
  display_name            = var.core_cross_connect_group_display_name != "" ? var.core_cross_connect_group_display_name : "${lower(var.name)}-cross-connect-group-${lower(var.environment)}-${count.index + 1}"

  dynamic "macsec_properties" {
    iterator = macsec_properties
    for_each = var.core_cross_connect_group_macsec_properties

    content {
      # Required
      state = lookup(macsec_properties.value, "state", null)

      # Optional
      encryption_cipher              = lookup(macsec_properties.value, "encryption_cipher", null)
      is_unprotected_traffic_allowed = lookup(macsec_properties.value, "is_unprotected_traffic_allowed", null)

      dynamic "primary_key" {
        iterator = primary_key
        for_each = length(keys(lookup(macsec_properties.value, "primary_key", {}))) > 0 ? [lookup(macsec_properties.value, "primary_key", {})] : []

        content {
          # Required
          connectivity_association_key_secret_id  = lookup(primary_key.value, "connectivity_association_key_secret_id", null)
          connectivity_association_name_secret_id = lookup(primary_key.value, "connectivity_association_name_secret_id", null)
        }
      }
    }
  }

  defined_tags = var.core_cross_connect_group_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_cross_connect_group_display_name != "" ? var.core_cross_connect_group_display_name : "${lower(var.name)}-cross-connect-group-${lower(var.environment)}-${count.index + 1}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_cross_connect_group_timeouts)) > 0 ? [var.core_cross_connect_group_timeouts] : []

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