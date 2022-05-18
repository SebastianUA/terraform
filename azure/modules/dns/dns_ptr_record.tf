#-----------------------------------------------------------
# Azure dns ptr record
#-----------------------------------------------------------
resource "azurerm_dns_ptr_record" "dns_ptr_record" {
  count = var.enable_dns_ptr_record ? 1 : 0

  name                = var.dns_ptr_record_name != "" ? var.dns_ptr_record_name : "${lower(var.name)}-dns-ptr-record-${lower(var.environment)}"
  zone_name           = var.dns_ptr_record_zone_name != "" ? var.dns_ptr_record_zone_name : (var.enable_dns_zone ? azurerm_dns_zone.dns_zone[count.index].name : null)
  resource_group_name = var.dns_ptr_record_resource_group_name
  ttl                 = var.dns_ptr_record_ttl
  records             = var.dns_ptr_record_records

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dns_ptr_record_timeouts)) > 0 ? [var.dns_ptr_record_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.dns_ptr_record_name != "" ? var.dns_ptr_record_name : "${lower(var.name)}-dns-ptr-record-${lower(var.environment)}"
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