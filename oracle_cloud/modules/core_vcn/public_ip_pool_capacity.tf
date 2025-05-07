#-----------------------------------------------------------
# core public ip pool capacity
#-----------------------------------------------------------
resource "oci_core_public_ip_pool_capacity" "core_public_ip_pool_capacity" {
  count = var.enable_core_public_ip_pool_capacity ? 1 : 0

  # Required
  public_ip_pool_id = var.core_public_ip_pool_capacity_public_ip_pool_id
  byoip_id          = var.core_public_ip_pool_capacity_byoip_id
  cidr_block        = var.core_public_ip_pool_capacity_cidr_block

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}