#-----------------------------------------------------------
# Azure subscription template deployment
#-----------------------------------------------------------
resource "azurerm_subscription_template_deployment" "subscription_template_deployment" {
  count = var.enable_subscription_template_deployment ? 1 : 0

  name     = var.subscription_template_deployment_name != "" ? var.subscription_template_deployment_name : "${lower(var.name)}-subscription-template-deployment-${lower(var.environment)}"
  location = var.subscription_template_deployment_location

  debug_level              = var.subscription_template_deployment_debug_level
  template_content         = var.subscription_template_deployment_template_content
  template_spec_version_id = var.subscription_template_deployment_template_spec_version_id
  parameters_content       = var.subscription_template_deployment_parameters_content


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
      Name = var.subscription_template_deployment_name != "" ? var.subscription_template_deployment_name : "${lower(var.name)}-subscription-template-deployment-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}