#-----------------------------------------------------------
# dns rrset
#-----------------------------------------------------------
resource "oci_dns_rrset" "dns_rrset" {
  count = var.enable_dns_rrset ? 1 : 0

  # Required
  domain          = var.dns_rrset_domain
  rtype           = var.dns_rrset_rtype
  zone_name_or_id = var.dns_rrset_zone_name_or_id && !var.enable_dns_zone ? var.dns_rrset_zone_name_or_id : (var.enable_dns_zone ? element(oci_dns_zone.dns_zone.*.id, 0) : null)

  # Optional
  dynamic "items" {
    iterator = items
    for_each = length(keys(var.dns_rrset_items)) > 0 ? [var.dns_rrset_items] : []

    content {
      # Required
      domain = lookup(items.value, "domain", null)
      rdata  = lookup(items.value, "rdata", null)
      rtype  = lookup(items.value, "rtype", null)
      ttl    = lookup(items.value, "ttl", null)
    }
  }

  scope   = var.dns_rrset_scopes
  view_id = var.dns_rrset_view_id && !var.enable_dns_view ? var.dns_rrset_view_id : (var.enable_dns_view ? element(oci_dns_view.dns_view.*.id, 0) : null)

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dns_rrset_timeouts)) > 0 ? [var.dns_rrset_timeouts] : []

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