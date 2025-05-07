#-----------------------------------------------------------
# compute cluster
#-----------------------------------------------------------
resource "oci_core_compute_cluster" "core_compute_cluster" {
  count = var.enable_core_compute_cluster ? 1 : 0

  # Required
  availability_domain = var.core_compute_cluster_availability_domain
  compartment_id      = var.compartment_id

  # Optional
  display_name = var.core_compute_cluster_display_name != "" ? var.core_compute_cluster_display_name : "${lower(var.name)}-compute-cluster-${lower(var.environment)}"

  defined_tags = var.core_compute_cluster_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_compute_cluster_display_name != "" ? var.core_compute_cluster_display_name : "${lower(var.name)}-compute-cluster-${lower(var.environment)}"
    },
    var.tags
  )
  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_compute_cluster_timeouts)) > 0 ? [var.core_compute_cluster_timeouts] : []

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