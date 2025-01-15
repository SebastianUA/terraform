#-----------------------------------------------------------
# core shape management
#-----------------------------------------------------------
resource "oci_core_shape_management" "core_shape_management" {
  count = var.enable_core_shape_management ? 1 : 0

  # Required
  compartment_id = var.core_shape_management_compartment_id
  image_id       = var.core_shape_management_image_id != "" && !var.enable_core_image ? var.core_shape_management_image_id : (var.enable_core_image ? element(oci_core_image.core_image.*.id, 0) : null)
  shape_name     = var.core_shape_management_shape_name

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}