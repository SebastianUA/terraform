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

  automatic                  = var.config_remediation_configuration_automatic
  maximum_automatic_attempts = var.config_remediation_configuration_maximum_automatic_attempts
  retry_attempt_seconds      = var.config_remediation_configuration_retry_attempt_seconds

  dynamic "parameter" {
    iterator = parameter
    for_each = var.config_remediation_configuration_parameter

    content {
      name = lookup(parameter.value, "name", null)

      resource_value = lookup(parameter.value, "resource_value", null)
      static_value   = lookup(parameter.value, "static_value", null)
      static_values  = lookup(parameter.value, "static_values", null)
    }
  }

  dynamic "execution_controls" {
    iterator = execution_controls
    for_each = length(keys(var.config_remediation_configuration_execution_controls)) > 0 ? [var.config_remediation_configuration_execution_controls] : []

    content {
      dynamic "ssm_controls" {
        iterator = ssm_controls
        for_each = length(keys(lookup(execution_controls.value, "ssm_controls", {}))) > 0 ? [lookup(execution_controls.value, "ssm_controls", {})] : []

        content {
          concurrent_execution_rate_percentage = lookup(ssm_controls.value, "concurrent_execution_rate_percentage", null)
          error_percentage                     = lookup(ssm_controls.value, "error_percentage", null)
        }
      }
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
