#-----------------------------------------------------------
# dedicated vm host
#-----------------------------------------------------------
resource "oci_core_dedicated_vm_host" "core_dedicated_vm_host" {
  count = var.enable_core_dedicated_vm_host ? 1 : 0

  # Required
  availability_domain     = var.core_dedicated_vm_host_availability_domain
  compartment_id          = var.compartment_id
  dedicated_vm_host_shape = var.core_dedicated_vm_host_dedicated_vm_host_shape

  # Optional
  display_name = var.core_dedicated_vm_host_display_name != "" ? var.core_dedicated_vm_host_display_name : "${lower(var.name)}-dedicated-vm-host-${lower(var.environment)}"
  fault_domain = var.core_dedicated_vm_host_fault_domain

  defined_tags = var.core_dedicated_vm_host_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_dedicated_vm_host_display_name != "" ? var.core_dedicated_vm_host_display_name : "${lower(var.name)}-dedicated-vm-host-${lower(var.environment)}"
    },
    var.tags
  )
  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_dedicated_vm_host_timeouts)) > 0 ? [var.core_dedicated_vm_host_timeouts] : []

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