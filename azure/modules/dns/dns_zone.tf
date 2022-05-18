#-----------------------------------------------------------
# Azure dns zone
#-----------------------------------------------------------
resource "azurerm_dns_zone" "dns_zone" {
  count = var.enable_dns_zone ? 1 : 0

  name                = var.dns_zone_name != "" ? var.dns_zone_name : "${lower(var.name)}-dns-zone-${lower(var.environment)}"
  resource_group_name = var.dns_zone_resource_group_name

  dynamic "soa_record" {
    iterator = soa_record
    for_each = length(keys(var.dns_zone_soa_record)) > 0 ? [var.dns_zone_soa_record] : []

    content {
      email     = lookup(soa_record.value, "email", null)
      host_name = lookup(soa_record.value, "host_name", null)

      expire_time   = lookup(soa_record.value, "expire_time", null)
      minimum_ttl   = lookup(soa_record.value, "minimum_ttl", null)
      refresh_time  = lookup(soa_record.value, "refresh_time", null)
      retry_time    = lookup(soa_record.value, "retry_time", null)
      serial_number = lookup(soa_record.value, "serial_number", null)
      ttl           = lookup(soa_record.value, "ttl", null)
      tags          = lookup(soa_record.value, "tags", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dns_zone_timeouts)) > 0 ? [var.dns_zone_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.dns_zone_name != "" ? var.dns_zone_name : "${lower(var.name)}-dns-zone-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}