#-----------------------------------------------------------
# core drg route table route rule
#-----------------------------------------------------------
resource "oci_core_drg_route_table_route_rule" "core_drg_route_table_route_rule" {
  count = var.enable_core_drg_route_table_route_rule ? 1 : 0

  # Required
  drg_route_table_id         = var.core_drg_route_table_route_rule_drg_route_table_id != "" && !var.enable_core_drg_route_table ? var.core_drg_route_table_route_rule_drg_route_table_id : (var.enable_core_drg_route_table ? element(oci_core_drg_route_table.core_drg_route_table.*.id, 0) : null)
  destination                = var.core_drg_route_table_route_rule_destination
  destination_type           = var.core_drg_route_table_route_rule_destination_type
  next_hop_drg_attachment_id = var.core_drg_route_table_route_rule_next_hop_drg_attachment_id != "" && !var.enable_core_drg_attachment ? var.core_drg_route_table_route_rule_next_hop_drg_attachment_id : (var.enable_core_drg_attachment ? element(oci_core_drg_attachment.core_drg_attachment.*.id, 0) : null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_drg_route_table_route_rule_timeouts)) > 0 ? [var.core_drg_route_table_route_rule_timeouts] : []

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