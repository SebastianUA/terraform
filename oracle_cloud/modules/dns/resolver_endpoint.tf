#-----------------------------------------------------------
# dns resolver endpoint
#-----------------------------------------------------------
resource "oci_dns_resolver_endpoint" "dns_resolver_endpoint" {
  count = var.enable_dns_resolver_endpoint ? 1 : 0

  # Required
  is_forwarding = var.dns_resolver_endpoint_is_forwarding
  is_listening  = var.dns_resolver_endpoint_is_listening
  name          = var.dns_resolver_endpoint_name != "" ? var.dns_resolver_endpoint_name : "${lower(var.name)}-dns-resolver-end-${lower(var.environment)}"
  resolver_id   = var.dns_resolver_endpoint_resolver_id != "" && !var.enable_dns_resolver ? var.dns_resolver_endpoint_resolver_id : (var.enable_dns_resolver ? element(oci_dns_resolver.dns_resolver.*.id, 0) : null)
  subnet_id     = var.dns_resolver_endpoint_subnet_id
  scope         = var.dns_resolver_endpoint_scope

  # Optional
  endpoint_type      = var.dns_resolver_endpoint_endpoint_type
  forwarding_address = var.dns_resolver_endpoint_forwarding_address
  listening_address  = var.dns_resolver_endpoint_listening_address
  nsg_ids            = var.dns_resolver_endpoint_nsg_ids

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dns_resolver_endpoint_timeouts)) > 0 ? [var.dns_resolver_endpoint_timeouts] : []

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