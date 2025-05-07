#-----------------------------------------------------------
# core route table (default)
#-----------------------------------------------------------
resource "oci_core_route_table" "core_route_table" {
  count = var.enable_core_route_table ? 1 : 0

  # Required
  compartment_id = var.compartment_id
  vcn_id         = var.core_route_table_vcn_id != "" && !var.enable_core_vcn ? var.core_route_table_vcn_id : (var.enable_core_vcn ? element(oci_core_vcn.core_vcn.*.id, 0) : null)

  # Optional
  display_name = var.core_route_table_display_name != "" ? var.core_route_table_display_name : "${lower(var.name)}-route-table-${lower(var.environment)}"

  dynamic "route_rules" {
    iterator = route_rules
    for_each = var.core_route_table_route_rules

    content {
      network_entity_id = lookup(route_rules.value, "network_entity_id", null)

      # Optional
      description      = lookup(route_rules.value, "description", null)
      destination      = lookup(route_rules.value, "destination", null)
      destination_type = lookup(route_rules.value, "destination_type", null)
    }
  }

  defined_tags = var.core_route_table_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_route_table_display_name != "" ? var.core_route_table_display_name : "${lower(var.name)}-route-table-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_route_table_timeouts)) > 0 ? [var.core_route_table_timeouts] : []

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
# core route table (public subnets)
#-----------------------------------------------------------
resource "oci_core_route_table" "core_route_table_publics" {
  count = var.enable_core_nat_gateway && length(var.core_subnet_publics_cidr_blocks) > 0 ? 1 : 0

  # Required
  compartment_id = var.compartment_id
  vcn_id         = var.core_route_table_publics_vcn_id != "" && !var.enable_core_vcn ? var.core_route_table_publics_vcn_id : (var.enable_core_vcn ? element(oci_core_vcn.core_vcn.*.id, 0) : null)

  # Optional
  display_name = var.core_route_table_publics_display_name != "" ? var.core_route_table_publics_display_name : "${lower(var.name)}-route-table-public-${lower(var.environment)}"

  route_rules {
    # Required
    network_entity_id = element(oci_core_nat_gateway.core_nat_gateway.*.id, 0)

    # Optional
    description      = "nat-gtw"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }

  defined_tags = var.core_route_table_publics_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_route_table_publics_display_name != "" ? var.core_route_table_publics_display_name : "${lower(var.name)}-route-table-public-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_route_table_publics_timeouts)) > 0 ? [var.core_route_table_publics_timeouts] : []

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
# core route table (private subnets)
#-----------------------------------------------------------
resource "oci_core_route_table" "core_route_table_privates" {
  count = var.enable_core_internet_gateway && length(var.core_subnet_privates_cidr_blocks) > 0 ? 1 : 0

  # Required
  compartment_id = var.compartment_id
  vcn_id         = var.core_route_table_privates_vcn_id != "" && !var.enable_core_vcn ? var.core_route_table_privates_vcn_id : (var.enable_core_vcn ? element(oci_core_vcn.core_vcn.*.id, 0) : null)

  # Optional
  display_name = var.core_route_table_privates_display_name != "" ? var.core_route_table_privates_display_name : "${lower(var.name)}-route-table-private-${lower(var.environment)}"

  route_rules {
    # Required
    network_entity_id = element(oci_core_internet_gateway.core_internet_gateway.*.id, 0)

    # Optional
    description      = "i-gtw"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }

  defined_tags = var.core_route_table_privates_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.core_route_table_privates_display_name != "" ? var.core_route_table_privates_display_name : "${lower(var.name)}-route-table-private-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.core_route_table_privates_timeouts)) > 0 ? [var.core_route_table_privates_timeouts] : []

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