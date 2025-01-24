#-----------------------------------------------------------
# bastion bastion
#-----------------------------------------------------------
resource "oci_bastion_bastion" "bastion" {
  count = var.enable_bastion ? 1 : 0

  # Required
  bastion_type     = var.bastion_bastion_type
  compartment_id   = var.bastion_compartment_id
  target_subnet_id = var.bastion_target_subnet_id

  # Optional
  name                          = var.bastion_name != "" ? var.bastion_name : "${lower(var.name)}-bastion-${lower(var.environment)}"
  client_cidr_block_allow_list  = var.bastion_client_cidr_block_allow_list
  dns_proxy_status              = var.bastion_dns_proxy_status
  max_session_ttl_in_seconds    = var.bastion_max_session_ttl_in_seconds
  phone_book_entry              = var.bastion_phone_book_entry
  static_jump_host_ip_addresses = var.bastion_static_jump_host_ip_addresses

  defined_tags = merge(
    {
      "company.Name" = var.bastion_name != "" ? var.bastion_name : "${lower(var.name)}-bastion-${lower(var.environment)}"
    },
    var.tags
  )

  freeform_tags = var.bastion_freeform_tags

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.bastion_timeouts)) > 0 ? [var.bastion_timeouts] : []

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