#-----------------------------------------------------------
# dns steering policy attachment
#-----------------------------------------------------------
resource "oci_dns_steering_policy_attachment" "dns_steering_policy_attachment" {
  count = var.enable_dns_steering_policy_attachment ? 1 : 0

  # Required
  domain_name        = var.dns_steering_policy_attachment_domain_name
  steering_policy_id = var.dns_steering_policy_attachment_steering_policy_id && !var.enable_dns_steering_policy ? var.dns_steering_policy_attachment_steering_policy_id : (var.enable_dns_steering_policy ? element(oci_dns_steering_policy.dns_steering_policy.*.id, 0) : null)
  zone_id            = var.dns_steering_policy_attachment_zone_id && !var.enable_dns_zone ? var.dns_steering_policy_attachment_zone_id : (var.enable_dns_zone ? element(oci_dns_zone.dns_zone.*.id, 0) : null)

  # Optional
  display_name = var.dns_steering_policy_attachment_display_name

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dns_steering_policy_attachment_timeouts)) > 0 ? [var.dns_steering_policy_attachment_timeouts] : []

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