#-----------------------------------------------------------
# core drg route distribution
#-----------------------------------------------------------
resource "oci_core_drg_route_distribution" "drg_route_distribution" {
  count = var.enable_drg_route_distribution ? 1 : 0

  # Required
  distribution_type = var.drg_route_distribution_distribution_type
  drg_id            = var.drg_route_distribution_drg_id != "" && !var.enable_core_drg ? var.drg_route_distribution_drg_id : (var.enable_core_drg ? element(oci_core_drg.core_drg.*.id, 0) : null)

  # Optional
  display_name = var.drg_route_distribution_display_name != "" ? var.drg_route_distribution_display_name : "${lower(var.name)}-drg-route-distribution-${lower(var.environment)}"

  defined_tags = var.drg_route_distribution_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.drg_route_distribution_display_name != "" ? var.drg_route_distribution_display_name : "${lower(var.name)}-drg-route-distribution-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.drg_route_distribution_timeouts)) > 0 ? [var.drg_route_distribution_timeouts] : []

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