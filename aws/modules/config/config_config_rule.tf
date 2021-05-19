#---------------------------------------------------
# AWS config config rule
#---------------------------------------------------
resource "aws_config_config_rule" "config_config_rule" {
  count = var.enable_config_config_rule ? 1 : 0

  name                        = var.config_config_rule_name != "" ? lower(var.config_config_rule_name) : "${lower(var.name)}-config-rule-${lower(var.environment)}"
  description                 = var.config_config_rule_description
  input_parameters            = var.config_config_rule_input_parameters
  maximum_execution_frequency = var.config_config_rule_maximum_execution_frequency

  dynamic "source" {
    iterator = source
    for_each = var.config_config_rule_source

    content {
      owner             = lookup(source.value, "owner", "AWS")
      source_identifier = lookup(source.value, "source_identifier", "S3_BUCKET_VERSIONING_ENABLED")
    }
  }

  dynamic "scope" {
    iterator = scope
    for_each = var.config_config_rule_scope

    content {
      compliance_resource_id    = lookup(scope.value, "compliance_resource_id", null)
      compliance_resource_types = lookup(scope.value, "compliance_resource_types", null)
      tag_key                   = lookup(scope.value, "tag_key", null)
      tag_value                 = lookup(scope.value, "tag_value", null)
    }
  }

  tags = merge(
    {
      Name = var.config_config_rule_name != "" ? lower(var.config_config_rule_name) : "${lower(var.name)}-config-rule-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
