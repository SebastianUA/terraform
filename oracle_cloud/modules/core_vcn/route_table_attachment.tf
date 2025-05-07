#-----------------------------------------------------------
# core route table attachment (default)
#-----------------------------------------------------------
resource "oci_core_route_table_attachment" "core_route_table_attachment" {
  # TODO: Add multile subnets (publics + privates)
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

#-----------------------------------------------------------
# core route table attachment (publics)
#-----------------------------------------------------------
resource "oci_core_route_table_attachment" "core_route_table_attachment_publics" {
  count = var.enable_core_nat_gateway && length(var.core_subnet_publics_cidr_blocks) > 0 ? length(var.core_subnet_publics_cidr_blocks) : 0

  # Required    
  subnet_id      = element(oci_core_subnet.core_subnet_publics.*.id, count.index)
  route_table_id = element(oci_core_route_table.core_route_table_publics.*.id, 0)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

#-----------------------------------------------------------
# core route table attachment (privates)
#-----------------------------------------------------------
resource "oci_core_route_table_attachment" "core_route_table_attachment_privates" {
  count = var.enable_core_nat_gateway && length(var.core_subnet_privates_cidr_blocks) > 0 ? length(var.core_subnet_privates_cidr_blocks) : 0

  # Required    
  subnet_id      = element(oci_core_subnet.core_subnet_privates.*.id, count.index)
  route_table_id = element(oci_core_route_table.core_route_table_privates.*.id, 0)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
