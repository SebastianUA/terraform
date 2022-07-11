#-----------------------------------------------------------
# Azure tenant template deployment
#-----------------------------------------------------------
output "tenant_template_deployment_id" {
  description = "The ID of the Tenant Template Deployment."
  value       = element(concat(azurerm_tenant_template_deployment.tenant_template_deployment.*.id, [""]), 0)
}

output "tenant_template_deployment_output_content" {
  description = "The JSON Content of the Outputs of the ARM Template Deployment."
  value       = concat(azurerm_tenant_template_deployment.tenant_template_deployment.*.output_content, [""])
}

#-----------------------------------------------------------
# Azure template deployment
#-----------------------------------------------------------
output "template_deployment_id" {
  description = "The Template Deployment ID."
  value       = element(concat(azurerm_template_deployment.template_deployment.*.id, [""]), 0)
}

output "template_deployment_outputs" {
  description = "A map of supported scalar output types returned from the deployment (currently, Azure Template Deployment outputs of type String, Int and Bool are supported, and are converted to strings - others will be ignored) and can be accessed using .outputs['name']."
  value       = concat(azurerm_template_deployment.template_deployment.*.outputs, [""])
}

#-----------------------------------------------------------
# Azure subscription template deployment
#-----------------------------------------------------------
output "subscription_template_deployment_id" {
  description = "The ID of the Subscription Template Deployment."
  value       = element(concat(azurerm_subscription_template_deployment.subscription_template_deployment.*.id, [""]), 0)
}

output "subscription_template_deployment_output_content" {
  description = "The JSON Content of the Outputs of the ARM Template Deployment."
  value       = concat(azurerm_subscription_template_deployment.subscription_template_deployment.*.output_content, [""])
}

#-----------------------------------------------------------
# Azure resource group template deployment
#-----------------------------------------------------------
output "resource_group_template_deployment_id" {
  description = "The ID of the Resource Group Template Deployment."
  value       = element(concat(azurerm_resource_group_template_deployment.resource_group_template_deployment.*.id, [""]), 0)
}

output "resource_group_template_deployment_" {
  description = "The JSON Content of the Outputs of the ARM Template Deployment."
  value       = concat(azurerm_resource_group_template_deployment.resource_group_template_deployment.*.output_content, [""])
}

#-----------------------------------------------------------
# Azure management group template deployment
#-----------------------------------------------------------
output "management_group_template_deployment_id" {
  description = "The ID of the Management Group Template Deployment."
  value       = element(concat(azurerm_management_group_template_deployment.management_group_template_deployment.*.id, [""]), 0)
}

output "management_group_template_deployment_output_content" {
  description = "The JSON Content of the Outputs of the ARM Template Deployment."
  value       = element(concat(azurerm_management_group_template_deployment.management_group_template_deployment.*.output_content, [""]), 0)
}
