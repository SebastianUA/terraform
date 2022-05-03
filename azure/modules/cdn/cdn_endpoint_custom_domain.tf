#-----------------------------------------------------------
# Azure cdn endpoint custom domain
#-----------------------------------------------------------
resource "azurerm_cdn_endpoint_custom_domain" "cdn_endpoint_custom_domain" {
  count = var.enable_cdn_endpoint_custom_domain ? 1 : 0

  name            = var.cdn_endpoint_custom_domain_name != "" ? var.cdn_endpoint_custom_domain_name : "${lower(var.name)}-cdn-endpoint-custom-domain-${lower(var.environment)}"
  cdn_endpoint_id = var.cdn_endpoint_custom_domain_cdn_endpoint_id != "" ? var.cdn_endpoint_custom_domain_cdn_endpoint_id : (var.enable_cdn_endpoint ? azurerm_cdn_endpoint.cdn_endpoint[count.index].id : null)
  host_name       = var.cdn_endpoint_custom_domain_host_name


  dynamic "cdn_managed_https" {
    iterator = cdn_managed_https
    for_each = length(keys(var.cdn_endpoint_custom_domain_cdn_managed_https)) > 0 ? [var.cdn_endpoint_custom_domain_cdn_managed_https] : []

    content {
      certificate_type = lookup(cdn_managed_https.value, "certificate_type", null)
      protocol_type    = lookup(cdn_managed_https.value, "protocol_type", null)

      tls_version = lookup(cdn_managed_https.value, "tls_version", null)
    }
  }

  dynamic "user_managed_https" {
    iterator = user_managed_https
    for_each = length(keys(var.cdn_endpoint_custom_domain_user_managed_https)) > 0 ? [var.cdn_endpoint_custom_domain_user_managed_https] : []

    content {
      key_vault_certificate_id = lookup(user_managed_https.value, "key_vault_certificate_id", null)

      tls_version = lookup(user_managed_https.value, "tls_version", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.cdn_endpoint_custom_domain_timeouts)) > 0 ? [var.cdn_endpoint_custom_domain_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.cdn_endpoint_custom_domain_name != "" ? var.cdn_endpoint_custom_domain_name : "${lower(var.name)}-cdn-endpoint-custom-domain-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_cdn_profile.cdn_endpoint
  ]
}