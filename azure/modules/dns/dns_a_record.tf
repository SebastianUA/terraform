#-----------------------------------------------------------
# Azure dns a record
#-----------------------------------------------------------
resource "azurerm_dns_a_record" "dns_a_record" {
  count = var.enable_dns_a_record ? 1 : 0

  name                = var.dns_a_record_name != "" ? var.dns_a_record_name : "${lower(var.name)}-dns-a-record-${lower(var.environment)}"
  zone_name           = var.dns_a_record_zone_name != "" ? var.dns_a_record_zone_name : (var.enable_dns_zone ? azurerm_dns_zone.dns_zone[count.index].name : null)
  resource_group_name = var.dns_a_record_resource_group_name
  ttl                 = var.dns_a_record_ttl
  records             = var.dns_a_record_records

  target_resource_id = var.dns_a_record_target_resource_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.dns_a_record_timeouts)) > 0 ? [var.dns_a_record_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.dns_a_record_name != "" ? var.dns_a_record_name : "${lower(var.name)}-dns-caa-record-${lower(var.environment)}"
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