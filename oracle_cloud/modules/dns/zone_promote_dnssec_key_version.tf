#-----------------------------------------------------------
# dns zone promote dnssec key version
#-----------------------------------------------------------
resource "oci_dns_zone_promote_dnssec_key_version" "zone_promote_dnssec_key_version" {
  count = var.enable_zone_promote_dnssec_key_version ? 1 : 0

  # Required
  dnssec_key_version_uuid = var.zone_promote_dnssec_key_version_dnssec_key_version_uuid
  zone_id                 = var.zone_promote_dnssec_key_version_zone_id && !var.enable_dns_zone ? var.zone_promote_dnssec_key_version_zone_id : (var.enable_dns_zone ? element(oci_dns_zone.dns_zone.*.id, 0) : null)

  # Optional
  scope = var.zone_promote_dnssec_key_version_scope

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.zone_stage_dnssec_key_version_timeouts)) > 0 ? [var.zone_stage_dnssec_key_version_timeouts] : []

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