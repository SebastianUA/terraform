#-----------------------------------------------------------
# Azure resource group template deployment
#-----------------------------------------------------------
resource "azurerm_resource_group_template_deployment" "resource_group_template_deployment" {
  count = var.enable_resource_group_template_deployment ? 1 : 0

  name                = var.resource_group_template_deployment_name != "" ? var.resource_group_template_deployment_name : "${lower(var.name)}-resource-group-template-deployment-${lower(var.environment)}"
  resource_group_name = var.resource_group_template_deployment_resource_group_name
  deployment_mode     = var.resource_group_template_deployment_deployment_mode

  debug_level              = var.resource_group_template_deployment_debug_level
  template_content         = var.resource_group_template_deployment_template_content
  template_spec_version_id = var.resource_group_template_deployment_template_spec_version_id
  parameters_content       = var.resource_group_template_deployment_parameters_content

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.resource_group_template_deployment_timeouts)) > 0 ? [var.resource_group_template_deployment_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.resource_group_template_deployment_name != "" ? var.resource_group_template_deployment_name : "${lower(var.name)}-resource-group-template-deployment-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}