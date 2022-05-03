#-----------------------------------------------------------
# Azure cdn profile
#-----------------------------------------------------------
resource "azurerm_cdn_profile" "cdn_profile" {
  count = var.enable_cdn_profile ? 1 : 0

  name                = var.cdn_profile_name != "" ? var.cdn_profile_name : "${lower(var.name)}-cdn-profile-${lower(var.environment)}"
  location            = var.cdn_profile_location
  resource_group_name = var.cdn_profile_resource_group_name
  sku                 = var.cdn_profile_sku

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.cdn_profile_timeouts)) > 0 ? [var.cdn_profile_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.cdn_profile_name != "" ? var.cdn_profile_name : "${lower(var.name)}-cdn-profile-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}