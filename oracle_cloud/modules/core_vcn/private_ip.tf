#-----------------------------------------------------------
# core private ip
#-----------------------------------------------------------
resource "oci_core_private_ip" "core_private_ip" {
  # TODO: add list with multiple IPs  
  count = var.enable_core_private_ip ? 1 : 0

  # Optional
  display_name   = var.core_private_ip_display_name != "" ? var.core_private_ip_display_name : "${lower(var.name)}-private-ip-${lower(var.environment)}-${count.index + 1}"
  hostname_label = var.core_private_ip_hostname_label
  ip_address     = var.core_private_ip_ip_address
  vlan_id        = var.core_private_ip_vlan_id != "" && !var.enable_core_vlan ? var.core_private_ip_vlan_id : (var.enable_core_vlan ? element(oci_core_vlan.core_vlan.*.id, 0) : null)
  vnic_id        = var.core_private_ip_vnic_id != "" && !var.enable_core_vnic_attachment ? var.core_private_ip_vnic_id : (var.enable_core_vnic_attachment ? element(oci_core_vnic_attachment.core_vnic_attachment.*.id, 0) : null)

  defined_tags = var.core_private_ip_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_private_ip_display_name != "" ? var.core_private_ip_display_name : "${lower(var.name)}-private-ip-${lower(var.environment)}-${count.index + 1}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_private_ip_timeouts)) > 0 ? [var.core_private_ip_timeouts] : []

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