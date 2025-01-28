#-----------------------------------------------------------
# core drg attachment management
#-----------------------------------------------------------
resource "oci_core_drg_attachment_management" "core_drg_attachment_management" {
  count = var.enable_core_drg_attachment_management ? 1 : 0

  # Required
  attachment_type = var.core_drg_attachment_management_attachment_type
  compartment_id  = var.compartment_id
  drg_id          = var.core_drg_attachment_management_drg_id != "" && !var.enable_core_drg ? var.core_drg_attachment_management_drg_id : (var.enable_core_drg ? element(oci_core_drg.core_drg.*.id, 0) : null)

  # Optional
  network_id         = var.core_drg_attachment_management_network_id
  display_name       = var.core_drg_attachment_management_display_name != "" ? var.core_drg_attachment_management_display_name : "${lower(var.name)}-drg-attachment-management-${lower(var.environment)}"
  drg_route_table_id = var.core_drg_attachment_management_drg_route_table_id != "" && !var.enable_core_drg_route_table ? var.core_drg_attachment_management_drg_route_table_id : (var.enable_core_drg_route_table ? element(oci_core_drg_route_table.core_drg_route_table.*.id, 0) : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}