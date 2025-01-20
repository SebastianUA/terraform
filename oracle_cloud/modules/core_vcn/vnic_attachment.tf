#-----------------------------------------------------------
# core vnic attachment
#-----------------------------------------------------------
resource "oci_core_vnic_attachment" "core_vnic_attachment" {
  # TODO: Add multiple attachments  
  count = var.enable_core_vnic_attachment ? 1 : 0

  # Required
  dynamic "create_vnic_details" {
    iterator = create_vnic_details
    for_each = var.core_vnic_attachment_create_vnic_details

    content {
      # Optional
      assign_ipv6ip             = lookup(create_vnic_details.value, "assign_ipv6ip", null)
      assign_private_dns_record = lookup(create_vnic_details.value, "assign_private_dns_record", null)
      assign_public_ip          = lookup(create_vnic_details.value, "assign_public_ip", null)
      defined_tags              = lookup(create_vnic_details.value, "defined_tags", null)
      display_name              = lookup(create_vnic_details.value, "display_name", null)
      freeform_tags             = lookup(create_vnic_details.value, "freeform_tags", null)
      hostname_label            = lookup(create_vnic_details.value, "hostname_label", null)
      # ipv6address_ipv6subnet_cidr_pair_details = lookup(create_vnic_details.value, "ipv6address_ipv6subnet_cidr_pair_details", null)
      nsg_ids                = lookup(create_vnic_details.value, "nsg_ids", null)
      private_ip             = lookup(create_vnic_details.value, "private_ip", null)
      security_attributes    = lookup(create_vnic_details.value, "security_attributes", null)
      skip_source_dest_check = lookup(create_vnic_details.value, "skip_source_dest_check", null)
      subnet_id              = lookup(create_vnic_details.value, "subnet_id", null) #oci_core_subnet.test_subnet.id
      vlan_id                = lookup(create_vnic_details.value, "vlan_id", null)   #oci_core_vlan.test_vlan.id
    }
  }
  instance_id = var.core_vnic_attachment_instance_id

  # Optional
  display_name = var.core_vnic_attachment_display_name != "" ? var.core_vnic_attachment_display_name : "${lower(var.name)}-vnic-attachment-${lower(var.environment)}"
  nic_index    = var.core_vnic_attachment_nic_index

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_vnic_attachment_timeouts)) > 0 ? [var.core_vnic_attachment_timeouts] : []

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