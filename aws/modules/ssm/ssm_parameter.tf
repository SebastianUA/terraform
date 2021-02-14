#-----------------------------------------------------------
# AWS SSM parameter
#-----------------------------------------------------------
resource "aws_ssm_parameter" "ssm_parameter" {
  count = var.enable_ssm_parameter ? 1 : 0

  name  = var.ssm_parameter_name != "" ? lower(var.ssm_parameter_name) : "/${var.environment}/database/password/master"
  type  = var.ssm_parameter_type
  value = var.ssm_parameter_value

  description     = var.ssm_parameter_description
  tier            = var.ssm_parameter_tier
  key_id          = var.ssm_parameter_key_id
  overwrite       = var.ssm_parameter_overwrite
  allowed_pattern = var.ssm_parameter_allowed_pattern

  tags = merge(
    {
      Name = var.ssm_parameter_name != "" ? lower(var.ssm_parameter_name) : "/${var.environment}/database/password/master"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
