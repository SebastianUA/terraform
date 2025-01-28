#-----------------------------------------------------------
# dns action create zone from zone file
#-----------------------------------------------------------
resource "oci_dns_action_create_zone_from_zone_file" "dns_action_create_zone_from_zone_file" {
  count = var.enable_dns_action_create_zone_from_zone_file ? 1 : 0

  # Required
  create_zone_from_zone_file_details = var.dns_action_create_zone_from_zone_file_create_zone_from_zone_file_details
  compartment_id                     = var.compartment_id

  # Optional
  scope   = var.dns_action_create_zone_from_zone_file_scope
  view_id = var.dns_action_create_zone_from_zone_file_view_id && !var.enable_dns_view ? var.dns_action_create_zone_from_zone_file_view_id : (var.enable_dns_view ? element(oci_dns_view.dns_view.*.id, 0) : null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dns_action_create_zone_from_zone_file_timeouts)) > 0 ? [var.dns_action_create_zone_from_zone_file_timeouts] : []

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