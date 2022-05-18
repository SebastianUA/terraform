#-----------------------------------------------------------
# Azure private dns txt record
#-----------------------------------------------------------
resource "azurerm_private_dns_txt_record" "private_dns_txt_record" {
  count = var.enable_private_dns_txt_record ? 1 : 0

  name                = var.private_dns_txt_record_name != "" ? var.private_dns_txt_record_name : "${lower(var.name)}-private-dns-txt-record-${lower(var.environment)}"
  zone_name           = var.private_dns_txt_record_zone_name != "" ? var.private_dns_txt_record_zone_name : (var.enable_dns_zone ? azurerm_dns_zone.private_dns_zone[count.index].name : null)
  resource_group_name = var.private_dns_txt_record_resource_group_name
  ttl                 = var.private_dns_txt_record_ttl

  dynamic "record" {
    iterator = record
    for_each = var.private_dns_txt_record_record

    content {
      value = lookup(record.value, "value", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.private_dns_txt_record_timeouts)) > 0 ? [var.private_dns_txt_record_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.private_dns_txt_record_name != "" ? var.private_dns_txt_record_name : "${lower(var.name)}-private-dns-txt-record-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_dns_zone.private_dns_zone
  ]
}