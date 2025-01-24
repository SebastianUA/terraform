#-----------------------------------------------------------
# dns zone
#-----------------------------------------------------------
resource "oci_dns_zone" "dns_zone" {
  count = var.enable_dns_zone ? 1 : 0

  # Required
  compartment_id = var.dns_zone_compartment_id
  name           = var.dns_zone_name != "" ? var.dns_zone_name : "${lower(var.name)}-dns-zone-${lower(var.environment)}"
  zone_type      = var.dns_zone_zone_type

  # Optional
  scope        = var.dns_zone_scope
  view_id      = var.dns_zone_view_id && !var.enable_dns_view ? var.dns_zone_view_id : (var.enable_dns_view ? element(oci_dns_view.dns_view.*.id, 0) : null)
  dnssec_state = var.dns_zone_dnssec_state

  dynamic "external_downstreams" {
    iterator = external_downstreams
    for_each = var.dns_zone_external_downstreams

    content {
      # Required
      address = lookup(external_downstreams.value, "address", null)

      # Optional
      port        = lookup(external_downstreams.value, "port", null)
      tsig_key_id = lookup(external_downstreams.value, "tsig_key_id", (var.enable_dns_tsig_key ? element(oci_dns_tsig_key.dns_tsig_key.*.id, 0) : null))
    }
  }

  dynamic "external_masters" {
    iterator = external_masters
    for_each = var.dns_zone_external_masters

    content {
      # Required
      address = lookup(external_masters.value, "address", null)

      # Optional
      port        = lookup(external_masters.value, "port", null)
      tsig_key_id = lookup(external_masters.value, "tsig_key_id", (var.enable_dns_tsig_key ? element(oci_dns_tsig_key.dns_tsig_key.*.id, 0) : null))
    }
  }

  defined_tags = var.dns_zone_defined_tags
  freeform_tags = merge(
    {
      "Name" = var.dns_zone_name != "" ? var.dns_zone_name : "${lower(var.name)}-dns-zone-${lower(var.environment)}"
    },
    var.tags
  )

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dns_zone_timeouts)) > 0 ? [var.dns_zone_timeouts] : []

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