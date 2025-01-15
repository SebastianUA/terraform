#-----------------------------------------------------------
# core drg route table
#-----------------------------------------------------------
resource "oci_core_drg_route_table" "core_drg_route_table" {
  count = var.enable_core_drg_route_table ? 1 : 0

  # Required
  drg_id = var.core_drg_route_table_drg_id != "" && !var.enable_core_drg ? var.core_drg_route_table_drg_id : (var.enable_core_drg ? element(oci_core_drg.core_drg.*.id, 0) : null)

  # Optional
  display_name                     = var.core_drg_route_table_display_name != "" ? var.core_drg_route_table_display_name : "${lower(var.name)}-drg-route-table-${lower(var.environment)}"
  import_drg_route_distribution_id = var.core_drg_route_table_import_drg_route_distribution_id != "" && !var.enable_core_drg ? var.core_drg_route_table_import_drg_route_distribution_id : (var.enable_core_drg ? element(oci_core_drg_route_distribution.core_drg_route_distribution.*.id, 0) : null)
  is_ecmp_enabled                  = var.core_drg_route_table_is_ecmp_enabled
  remove_import_trigger            = var.core_drg_route_table_remove_import_trigger

  defined_tags = merge(
    {
      Name = var.core_drg_route_table_display_name != "" ? var.core_drg_route_table_display_name : "${lower(var.name)}-drg-route-table-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.core_drg_route_table_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_drg_route_table_timeouts)) > 0 ? [var.core_drg_route_table_timeouts] : []

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