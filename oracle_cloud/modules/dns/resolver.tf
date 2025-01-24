#-----------------------------------------------------------
# dns resolver
#-----------------------------------------------------------
resource "oci_dns_resolver" "dns_resolver" {
  count = var.enable_dns_resolver ? 1 : 0

  # Required
  resolver_id = var.dns_resolver_resolver_id != "" && !var.enable_dns_resolver ? var.dns_resolver_resolver_id : (var.enable_dns_resolver ? element(oci_dns_resolver.dns_resolver.*.id, 0) : null)

  # Optional
  scope        = var.dns_resolver_scope
  display_name = var.dns_resolver_display_name != "" ? var.dns_resolver_display_name : "${lower(var.name)}-dns-resolver-${lower(var.environment)}"

  dynamic "attached_views" {
    iterator = attached_views
    for_each = var.dns_resolver_attached_views

    content {
      # Required
      view_id = lookup(attached_views.value, "view_id", null)
    }
  }

  defined_tags = merge(
    {
      "company.Name" = var.dns_resolver_display_name != "" ? var.dns_resolver_display_name : "${lower(var.name)}-dns-resolver-${lower(var.environment)}"
    },
    var.tags
  )
  freeform_tags = var.dns_resolver_freeform_tags

  dynamic "rules" {
    iterator = rules
    for_each = var.dns_resolver_rules

    content {
      # Required
      action                = lookup(rules.value, "action", null)
      destination_addresses = lookup(rules.value, "destination_addresses", null)
      source_endpoint_name  = lookup(rules.value, "source_endpoint_name", null)

      # Optional
      client_address_conditions = lookup(rules.value, "client_address_conditions", null)
      qname_cover_conditions    = lookup(rules.value, "qname_cover_conditions", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dns_resolver_timeouts)) > 0 ? [var.dns_resolver_timeouts] : []

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