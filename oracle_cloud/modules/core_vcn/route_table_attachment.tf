#-----------------------------------------------------------
# core route table attachment
#-----------------------------------------------------------
resource "oci_core_route_table_attachment" "core_route_table_attachment" {
  count = var.enable_core_route_table_attachment ? 1 : 0

  # Required    
  subnet_id      = var.core_route_table_attachment_subnet_id != "" && !var.enable_core_subnet ? var.core_route_table_attachment_subnet_id : (var.enable_core_subnet ? element(oci_core_subnet.core_subnet.*.id, 0) : null)
  route_table_id = var.core_route_table_attachment_route_table_id != "" && !var.enable_core_route_table ? var.core_route_table_attachment_route_table_id : (var.enable_core_route_table ? element(oci_core_route_table.core_route_table.*.id, 0) : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}