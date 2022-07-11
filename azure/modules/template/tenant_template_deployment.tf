#-----------------------------------------------------------
# Azure tenant template deployment
#-----------------------------------------------------------
resource "azurerm_tenant_template_deployment" "tenant_template_deployment" {
  count = var.enable_tenant_template_deployment ? 1 : 0

  name     = var.tenant_template_deployment_name != "" ? var.tenant_template_deployment_name : "${lower(var.name)}-tenant-template-deployment-${lower(var.environment)}"
  location = var.tenant_template_deployment_location

  debug_level              = var.tenant_template_deployment_debug_level
  parameters_content       = var.tenant_template_deployment_parameters_content
  template_content         = var.tenant_template_deployment_template_content
  template_spec_version_id = var.tenant_template_deployment_template_spec_version_id

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.tenant_template_deployment_timeouts)) > 0 ? [var.tenant_template_deployment_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      read   = lookup(timeouts.value, "read", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.tenant_template_deployment_name != "" ? var.tenant_template_deployment_name : "${lower(var.name)}-tenant-template-deployment-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}