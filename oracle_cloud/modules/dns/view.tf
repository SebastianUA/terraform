#-----------------------------------------------------------
# dns view
#-----------------------------------------------------------
resource "oci_dns_view" "dns_view" {
  count = var.enable_dns_view ? 1 : 0

  # Required
  compartment_id = var.dns_view_compartment_id

  # Optional
  display_name = var.dns_view_display_name != "" ? var.dns_view_display_name : "${lower(var.name)}-dns-view-${lower(var.environment)}"
  scope        = var.dns_view_scope

  defined_tags = var.dns_view_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.dns_view_display_name != "" ? var.dns_view_display_name : "${lower(var.name)}-dns-view-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dns_view_timeouts)) > 0 ? [var.dns_view_timeouts] : []

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