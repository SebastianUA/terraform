#-----------------------------------------------------------
# dns record
#-----------------------------------------------------------
resource "oci_dns_record" "dns_record" {
  count = var.enable_dns_record ? 1 : 0

  # Required
  zone_name_or_id = var.dns_record_zone_name_or_id != "" ? var.dns_record_zone_name_or_id : (var.enable_dns_zone ? element(oci_dns_zone.dns_zone.*.id, 0) : null)
  domain          = var.dns_record_domain
  rtype           = var.dns_record_rtype

  # Optional
  rdata          = var.dns_record_rdata
  ttl            = var.dns_record_ttl
  compartment_id = var.compartment_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dns_record_timeouts)) > 0 ? [var.dns_record_timeouts] : []

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