#-----------------------------------------------------------
# Azure eventgrid domain topic
#-----------------------------------------------------------
resource "azurerm_eventgrid_domain_topic" "eventgrid_domain_topic" {
  count = var.enable_eventgrid_domain_topic ? 1 : 0

  name                = var.eventgrid_domain_topic_name != "" ? var.eventgrid_domain_topic_name : "${lower(var.name)}-eventgrid-domain-topic-${lower(var.environment)}"
  domain_name         = var.eventgrid_domain_topic_domain_name != "" ? var.eventgrid_domain_topic_domain_name : (var.enable_eventgrid_domain ? azurerm_eventgrid_domain.eventgrid_domain[count.index].name : null)
  resource_group_name = var.eventgrid_domain_topic_resource_group_name

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.eventgrid_domain_topic_timeouts)) > 0 ? [var.eventgrid_domain_topic_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.eventgrid_domain_topic_name != "" ? var.eventgrid_domain_topic_name : "${lower(var.name)}-eventgrid-domain-topic-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    azurerm_eventgrid_domain.eventgrid_domain
  ]
}