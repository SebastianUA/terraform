#-----------------------------------------------------------
# core public ip pool
#-----------------------------------------------------------
resource "oci_core_public_ip_pool" "core_public_ip_pool" {
  count = var.enable_core_public_ip_pool ? 1 : 0

  # Required
  compartment_id = var.core_public_ip_pool_compartment_id

  # Optional
  display_name = var.core_public_ip_pool_display_name != "" ? var.core_public_ip_pool_display_name : "${lower(var.name)}-public-ip-${lower(var.environment)}-${count.index + 1}"

  defined_tags = merge(
    {
      Name = var.core_public_ip_pool_display_name != "" ? var.core_public_ip_pool_display_name : "${lower(var.name)}-public-ip-${lower(var.environment)}-${count.index + 1}"
    },
    var.tags
  )
  freeform_tags = var.core_public_ip_pool_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_public_ip_pool_timeouts)) > 0 ? [var.core_public_ip_pool_timeouts] : []

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