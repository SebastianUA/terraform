#-----------------------------------------------------------
# Azure management group template deployment
#-----------------------------------------------------------
resource "azurerm_management_group_template_deployment" "management_group_template_deployment" {
  count = var.enable_management_group_template_deployment ? 1 : 0

  name                = var.management_group_template_deployment_name != "" ? var.management_group_template_deployment_name : "${lower(var.name)}-management-group-template-deployment-${lower(var.environment)}"
  management_group_id = var.management_group_template_deployment_management_group_id
  location            = var.management_group_template_deployment_location

  debug_level              = var.management_group_template_deployment_debug_level
  parameters_content       = var.management_group_template_deployment_parameters_content
  template_content         = var.management_group_template_deployment_template_content
  template_spec_version_id = var.management_group_template_deployment_template_spec_version_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.subscription_template_deployment_timeouts)) > 0 ? [var.subscription_template_deployment_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.management_group_template_deployment_name != "" ? var.management_group_template_deployment_name : "${lower(var.name)}-management-group-template-deployment-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}