#---------------------------------------------------
# AWS config remediation configuration
#---------------------------------------------------
resource "aws_config_remediation_configuration" "config_remediation_configuration" {
  count = var.enable_config_remediation_configuration ? 1 : 0

  config_rule_name = var.config_remediation_configuration_config_rule_name != "" ? var.config_remediation_configuration_config_rule_name : (var.enable_config_config_rule ? element(aws_config_config_rule.config_config_rule.*.name, 0) : null)
  target_id        = var.config_remediation_configuration_target_id
  target_type      = var.config_remediation_configuration_target_type

  resource_type  = var.config_remediation_configuration_resource_type
  target_version = var.config_remediation_configuration_target_version

  dynamic "parameter" {
    iterator = parameter
    for_each = var.config_remediation_configuration_parameter
    content {
      name = lookup(parameter.value, "name", null)

      resource_value = lookup(parameter.value, "resource_value", null)
      static_value   = lookup(parameter.value, "static_value", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_config_config_rule.config_config_rule
  ]
}
