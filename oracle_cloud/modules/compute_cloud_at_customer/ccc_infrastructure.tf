#-----------------------------------------------------------
# compute cloud at customer ccc infrastructure
#-----------------------------------------------------------
resource "oci_compute_cloud_at_customer_ccc_infrastructure" "ccc_infrastructure" {
  count = var.enable_ccc_infrastructure ? 1 : 0

  # Required
  compartment_id = var.compartment_id
  display_name   = var.ccc_infrastructure_display_name != "" ? var.ccc_infrastructure_display_name : "${lower(var.name)}-ccc-infra-${lower(var.environment)}"
  subnet_id      = var.ccc_infrastructure_subnet_id

  # Optional
  description             = var.ccc_infrastructure_description
  ccc_upgrade_schedule_id = var.ccc_infrastructure_ccc_upgrade_schedule_id != null && !var.enable_ccc_upgrade_schedule ? var.ccc_infrastructure_ccc_upgrade_schedule_id : (var.enable_ccc_upgrade_schedule ? element(oci_compute_cloud_at_customer_ccc_upgrade_schedule.ccc_upgrade_schedule.*.id, 0) : null)
  connection_details      = var.ccc_infrastructure_connection_details
  connection_state        = var.ccc_infrastructure_connection_state

  defined_tags = var.ccc_infrastructure_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.ccc_infrastructure_display_name != "" ? var.ccc_infrastructure_display_name : "${lower(var.name)}-ccc-infra-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.ccc_infrastructure_timeouts)) > 0 ? [var.ccc_infrastructure_timeouts] : []

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