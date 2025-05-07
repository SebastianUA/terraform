#-----------------------------------------------------------
# core subnet (default)
#-----------------------------------------------------------
resource "oci_core_subnet" "core_subnet" {
  count = var.enable_core_subnet ? 1 : 0

  # Required
  cidr_block     = var.core_subnet_cidr_block
  compartment_id = var.compartment_id
  vcn_id         = var.core_subnet_vcn_id != "" && !var.enable_core_vcn ? var.core_subnet_vcn_id : (var.enable_core_vcn ? element(oci_core_vcn.core_vcn.*.id, 0) : null)

  # Optional
  availability_domain        = var.core_subnet_availability_domain
  dhcp_options_id            = var.core_subnet_dhcp_options_id != "" && !var.enable_core_dhcp_options ? var.core_subnet_dhcp_options_id : (var.enable_core_dhcp_options ? element(oci_core_dhcp_options.core_dhcp_options.*.id, 0) : null)
  display_name               = var.core_subnet_display_name != "" ? var.core_subnet_display_name : "${lower(var.name)}-subnet-${lower(var.environment)}-${count.index + 1}"
  dns_label                  = var.core_subnet_dns_label
  ipv6cidr_block             = var.core_subnet_ipv6cidr_block
  ipv6cidr_blocks            = var.core_subnet_ipv6cidr_blocks
  prohibit_internet_ingress  = var.core_subnet_prohibit_internet_ingress
  prohibit_public_ip_on_vnic = var.core_subnet_prohibit_public_ip_on_vnic
  route_table_id             = var.core_subnet_route_table_id != "" && !var.enable_core_route_table ? var.core_subnet_route_table_id : (var.enable_core_route_table ? element(oci_core_route_table.core_route_table.*.id, 0) : null)
  security_list_ids          = var.core_subnet_security_list_ids

  defined_tags = var.core_subnet_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_subnet_display_name != "" ? var.core_subnet_display_name : "${lower(var.name)}-subnet-${lower(var.environment)}-${count.index + 1}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_subnet_timeouts)) > 0 ? [var.core_subnet_timeouts] : []

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

#-----------------------------------------------------------
# core subnet (privates)
#-----------------------------------------------------------
resource "oci_core_subnet" "core_subnet_privates" {
  count = length(var.core_subnet_privates_cidr_blocks)

  # Required
  cidr_block     = var.core_subnet_privates_cidr_blocks[count.index]
  compartment_id = var.compartment_id
  vcn_id         = var.core_subnet_privates_vcn_id != "" && !var.enable_core_vcn ? var.core_subnet_privates_vcn_id : (var.enable_core_vcn ? element(oci_core_vcn.core_vcn.*.id, 0) : null)

  # Optional
  availability_domain        = var.core_subnet_privates_availability_domain
  dhcp_options_id            = var.core_subnet_privates_dhcp_options_id != "" && !var.enable_core_dhcp_options ? var.core_subnet_privates_dhcp_options_id : (var.enable_core_dhcp_options ? element(oci_core_dhcp_options.core_dhcp_options.*.id, 0) : null)
  display_name               = var.core_subnet_privates_display_name != "" ? var.core_subnet_privates_display_name : "${lower(var.name)}-private-subnet-${lower(var.environment)}-${count.index + 1}"
  dns_label                  = var.core_subnet_privates_dns_label
  ipv6cidr_block             = var.core_subnet_privates_ipv6cidr_block
  ipv6cidr_blocks            = var.core_subnet_privates_ipv6cidr_blocks
  prohibit_internet_ingress  = var.core_subnet_privates_prohibit_internet_ingress
  prohibit_public_ip_on_vnic = var.core_subnet_privates_prohibit_public_ip_on_vnic
  route_table_id             = var.core_subnet_privates_route_table_id != "" && !var.enable_core_route_table ? var.core_subnet_privates_route_table_id : (var.enable_core_route_table ? element(oci_core_route_table.core_route_table_privates.*.id, 0) : null)
  security_list_ids          = var.core_subnet_privates_security_list_ids

  defined_tags = var.core_subnet_privates_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_subnet_privates_display_name != "" ? var.core_subnet_privates_display_name : "${lower(var.name)}-private-subnet-${lower(var.environment)}-${count.index + 1}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_subnet_privates_timeouts)) > 0 ? [var.core_subnet_privates_timeouts] : []

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

#-----------------------------------------------------------
# core subnet (publics)
#-----------------------------------------------------------
resource "oci_core_subnet" "core_subnet_publics" {
  count = length(var.core_subnet_publics_cidr_blocks)

  # Required
  cidr_block     = var.core_subnet_publics_cidr_blocks[count.index]
  compartment_id = var.compartment_id
  vcn_id         = var.core_subnet_publics_vcn_id != "" && !var.enable_core_vcn ? var.core_subnet_publics_vcn_id : (var.enable_core_vcn ? element(oci_core_vcn.core_vcn.*.id, 0) : null)

  # Optional
  availability_domain        = var.core_subnet_publics_availability_domain
  dhcp_options_id            = var.core_subnet_publics_dhcp_options_id != "" && !var.enable_core_dhcp_options ? var.core_subnet_publics_dhcp_options_id : (var.enable_core_dhcp_options ? element(oci_core_dhcp_options.core_dhcp_options.*.id, 0) : null)
  display_name               = var.core_subnet_publics_display_name != "" ? var.core_subnet_publics_display_name : "${lower(var.name)}-public-subnet-${lower(var.environment)}-${count.index + 1}"
  dns_label                  = var.core_subnet_publics_dns_label
  ipv6cidr_block             = var.core_subnet_publics_ipv6cidr_block
  ipv6cidr_blocks            = var.core_subnet_publics_ipv6cidr_blocks
  prohibit_internet_ingress  = var.core_subnet_publics_prohibit_internet_ingress
  prohibit_public_ip_on_vnic = var.core_subnet_publics_prohibit_public_ip_on_vnic
  route_table_id             = var.core_subnet_publics_route_table_id != "" && !var.enable_core_route_table ? var.core_subnet_publics_route_table_id : (var.enable_core_route_table ? element(oci_core_route_table.core_route_table_publics.*.id, 0) : null)
  security_list_ids          = var.core_subnet_publics_security_list_ids

  defined_tags = var.core_subnet_publics_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_subnet_publics_display_name != "" ? var.core_subnet_publics_display_name : "${lower(var.name)}-public-subnet-${lower(var.environment)}-${count.index + 1}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_subnet_publics_timeouts)) > 0 ? [var.core_subnet_publics_timeouts] : []

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