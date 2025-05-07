#-----------------------------------------------------------
# compute capacity topology
#-----------------------------------------------------------
resource "oci_core_compute_capacity_topology" "core_compute_capacity_topology" {
  count = var.enable_core_compute_capacity_topology ? 1 : 0

  # Required
  availability_domain = var.core_compute_capacity_topology_availability_domain

  dynamic "capacity_source" {
    iterator = capacity_source
    for_each = var.core_compute_capacity_topology_capacity_source
    content {
      # Required
      capacity_type = lookup(capacity_source.value, "capacity_type", null)

      # Optional
      compartment_id = lookup(capacity_source.value, "compartment_id", null)
    }
  }
  compartment_id = var.compartment_id

  # Optional
  display_name = var.core_compute_capacity_topology_display_name != "" ? var.core_compute_capacity_topology_display_name : "${lower(var.name)}-compute-capacity-topology-${lower(var.environment)}"

  defined_tags = var.core_compute_capacity_topology_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_compute_capacity_topology_display_name != "" ? var.core_compute_capacity_topology_display_name : "${lower(var.name)}-compute-capacity-topology-${lower(var.environment)}"
    },
    var.tags
  )
  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_compute_capacity_topology_timeouts)) > 0 ? [var.core_compute_capacity_topology_timeouts] : []

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