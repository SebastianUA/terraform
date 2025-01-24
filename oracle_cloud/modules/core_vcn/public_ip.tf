#-----------------------------------------------------------
# core public ip
#-----------------------------------------------------------
resource "oci_core_public_ip" "core_public_ip" {
  # TODO: add list with multiple IPs  
  count = var.enable_core_public_ip ? 1 : 0

  # Required
  compartment_id = var.core_public_ip_compartment_id
  lifetime       = var.core_public_ip_lifetime

  # Optional
  display_name      = var.core_public_ip_display_name != "" ? var.core_public_ip_display_name : "${lower(var.name)}-public-ip-${lower(var.environment)}-${count.index + 1}"
  private_ip_id     = var.core_public_ip_private_ip_id != "" && !var.enable_core_private_ip ? var.core_public_ip_private_ip_id : (var.enable_core_private_ip ? element(oci_core_private_ip.core_private_ip.*.id, 0) : null)
  public_ip_pool_id = var.core_public_ip_public_ip_pool_id != "" && !var.enable_core_public_ip_pool ? var.core_public_ip_public_ip_pool_id : (var.enable_core_public_ip_pool ? element(oci_core_public_ip_pool.core_public_ip_pool.*.id, 0) : null)

  defined_tags = var.core_public_ip_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_public_ip_display_name != "" ? var.core_public_ip_display_name : "${lower(var.name)}-public-ip-${lower(var.environment)}-${count.index + 1}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_public_ip_timeouts)) > 0 ? [var.core_public_ip_timeouts] : []

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