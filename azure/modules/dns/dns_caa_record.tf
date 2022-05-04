#-----------------------------------------------------------
# Azure dns caa record
#-----------------------------------------------------------
resource "azurerm_dns_caa_record" "dns_caa_record" {
  count = var.enable_dns_caa_record ? 1 : 0

  name                = var.dns_caa_record_name != "" ? var.dns_caa_record_name : "${lower(var.name)}-dns-caa-record-${lower(var.environment)}"
  zone_name           = var.dns_caa_record_zone_name != "" ? var.dns_caa_record_zone_name : (var.enable_dns_zone ? azurerm_dns_zone.dns_zone[count.index].name : null)
  resource_group_name = var.dns_caa_record_resource_group_name
  ttl                 = var.dns_caa_record_ttl

  dynamic "record" {
    iterator = record
    for_each = var.dns_caa_record_record

    content {
      flags = lookup(record.value, "flags", null)
      tag   = lookup(record.value, "tag", null)
      value = lookup(record.value, "value", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dns_caa_record_timeouts)) > 0 ? [var.dns_caa_record_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.dns_caa_record_name != "" ? var.dns_caa_record_name : "${lower(var.name)}-dns-caa-record-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_dns_zone.dns_zone
  ]
}