#-----------------------------------------------------------
# Azure eventgrid topic
#-----------------------------------------------------------
output "eventgrid_topic_id" {
  description = "The EventGrid Topic ID."
  value       = element(concat(azurerm_eventgrid_topic.eventgrid_topic.*.id, [""]), 0)
}

output "eventgrid_topic_endpoint" {
  description = "The Endpoint associated with the EventGrid Topic."
  value       = element(concat(azurerm_eventgrid_topic.eventgrid_topic.*.endpoint, [""]), 0)
}

output "eventgrid_topic_primary_access_key" {
  description = "The Primary Shared Access Key associated with the EventGrid Topic."
  value       = element(concat(azurerm_eventgrid_topic.eventgrid_topic.*.primary_access_key, [""]), 0)
}

output "eventgrid_topic_secondary_access_key" {
  description = "The Secondary Shared Access Key associated with the EventGrid Topic."
  value       = element(concat(azurerm_eventgrid_topic.eventgrid_topic.*.secondary_access_key, [""]), 0)
}

output "eventgrid_topic_identity" {
  description = "The identity block with principal_id and tenant_id"
  value       = concat(azurerm_eventgrid_topic.eventgrid_topic.*.identity, [""])
}

#-----------------------------------------------------------
# Azure eventgrid system topic
#-----------------------------------------------------------
output "eventgrid_system_topic_id" {
  description = "The ID of the Event Grid System Topic."
  value       = element(concat(azurerm_eventgrid_system_topic.eventgrid_system_topic.*.id, [""]), 0)
}

output "eventgrid_system_topic_identity" {
  description = "An identity block"
  value       = concat(azurerm_eventgrid_system_topic.eventgrid_system_topic.*.identity, [""])
}

output "eventgrid_system_topic_metric_arm_resource_id" {
  description = "The Metric ARM Resource ID of the Event Grid System Topic."
  value       = element(concat(azurerm_eventgrid_system_topic.eventgrid_system_topic.*.metric_arm_resource_id, [""]), 0)
}

#-----------------------------------------------------------
# Azure eventgrid system topic event subscription
#-----------------------------------------------------------
output "eventgrid_system_topic_event_subscription_id" {
  description = "The ID of the EventGrid System Topic."
  value       = element(concat(azurerm_eventgrid_system_topic_event_subscription.eventgrid_system_topic_event_subscription.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure eventgrid event subscription
#-----------------------------------------------------------
output "eventgrid_event_subscription_id" {
  description = "The ID of the EventGrid System Topic."
  value       = element(concat(azurerm_eventgrid_event_subscription.eventgrid_event_subscription.*.id, [""]), 0)
}

#-----------------------------------------------------------
# Azure eventgrid domain
#-----------------------------------------------------------
output "eventgrid_domain_id" {
  description = "The ID of the EventGrid Domain."
  value       = element(concat(azurerm_eventgrid_domain.eventgrid_domain.*.id, [""]), 0)
}

output "eventgrid_domain_endpoint" {
  description = "The Endpoint associated with the EventGrid Domain."
  value       = element(concat(azurerm_eventgrid_domain.eventgrid_domain.*.endpoint, [""]), 0)
}

output "eventgrid_domain_primary_access_key" {
  description = "The Primary Shared Access Key associated with the EventGrid Domain."
  value       = element(concat(azurerm_eventgrid_domain.eventgrid_domain.*.primary_access_key, [""]), 0)
}

output "eventgrid_domain_secondary_access_key" {
  description = "The Secondary Shared Access Key associated with the EventGrid Domain."
  value       = element(concat(azurerm_eventgrid_domain.eventgrid_domain.*.secondary_access_key, [""]), 0)
}

output "eventgrid_domain_identity" {
  description = "An identity block as defined below, which contains the Managed Service Identity information for this Event Grid Domain."
  value       = concat(azurerm_eventgrid_domain.eventgrid_domain.*.identity, [""])
}

#-----------------------------------------------------------
# Azure eventgrid domain topic
#-----------------------------------------------------------
output "eventgrid_domain_topic_id" {
  description = "The ID of the EventGrid Domain Topic."
  value       = element(concat(azurerm_eventgrid_domain_topic.eventgrid_domain_topic.*.id, [""]), 0)
}