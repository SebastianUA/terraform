#-----------------------------------------------------------
# Azure template deployment
#-----------------------------------------------------------
resource "azurerm_template_deployment" "template_deployment" {
  count = var.enable_template_deployment ? 1 : 0

  name                = var.template_deployment_name != "" ? var.template_deployment_name : "${lower(var.name)}-template-deployment-${lower(var.environment)}"
  resource_group_name = var.template_deployment_resource_group_name
  deployment_mode     = var.template_deployment_deployment_mode

  template_body   = var.template_deployment_template_body
  parameters      = var.template_deployment_parameters
  parameters_body = var.template_deployment_parameters_body

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.template_deployment_timeouts)) > 0 ? [var.template_deployment_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
