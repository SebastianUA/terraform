#---------------------------------------------------
# AWS config organization managed rule
#---------------------------------------------------
resource "aws_config_organization_managed_rule" "config_organization_managed_rule" {
  count = var.enable_organizations_organization && var.enable_config_organization_managed_rule ? 1 : 0

  name            = var.config_organization_managed_rule_name != "" ? lower(var.config_organization_managed_rule_name) : "${lower(var.name)}-config-org-managed-rule-${lower(var.environment)}"
  rule_identifier = upper(var.config_organization_managed_rule_identifier)

  description                 = var.config_organization_managed_rule_description != null ? var.config_organization_managed_rule_description : null
  excluded_accounts           = var.config_organization_managed_rule_excluded_accounts != null ? var.config_organization_managed_rule_excluded_accounts : null
  input_parameters            = var.config_organization_managed_rule_input_parameters != null ? var.config_organization_managed_rule_input_parameters : null
  maximum_execution_frequency = var.config_organization_managed_rule_maximum_execution_frequency != null ? var.config_organization_managed_rule_maximum_execution_frequency : null
  resource_id_scope           = var.config_organization_managed_rule_resource_id_scope != null ? var.config_organization_managed_rule_resource_id_scope : null
  resource_types_scope        = var.config_organization_managed_rule_resource_types_scope != null ? var.config_organization_managed_rule_resource_types_scope : null
  tag_key_scope               = var.config_organization_managed_rule_tag_key_scope != null ? var.config_organization_managed_rule_tag_key_scope : null
  tag_value_scope             = var.config_organization_managed_rule_tag_value_scope != null ? var.config_organization_managed_rule_tag_value_scope : null

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.config_organization_managed_rule_timeouts)) > 0 ? [var.config_organization_managed_rule_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
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
