#-----------------------------------------------------------
# core ipv6
#-----------------------------------------------------------
resource "oci_core_ipv6" "core_ipv6" {
  # TODO: Add multiple IPv6
  count = var.enable_core_ipv6 ? 1 : 0

  # Required
  vnic_id = var.core_ipv6_vnic_id != "" && !var.enable_core_vnic_attachment ? var.core_ipv6_vnic_id : (var.enable_core_vnic_attachment ? element(oci_core_vnic_attachment.core_vnic_attachment.*.id, 0) : null)

  # Optional
  display_name    = var.core_ipv6_display_name != "" ? var.core_ipv6_display_name : "${lower(var.name)}-ipv6-${lower(var.environment)}-${count.index + 1}"
  ip_address      = var.core_ipv6_ip_address
  ipv6subnet_cidr = var.core_ipv6_ipv6subnet_cidr

  defined_tags = merge(
    {
      "company.Name" = var.core_ipv6_display_name != "" ? var.core_ipv6_display_name : "${lower(var.name)}-ipv6-${lower(var.environment)}-${count.index + 1}"
    },
    var.tags
  )
  freeform_tags = var.core_ipv6_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_ipv6_timeouts)) > 0 ? [var.core_ipv6_timeouts] : []

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