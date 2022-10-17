#---------------------------------------------------
# AWS CloudWatch LOG group
#---------------------------------------------------
resource "aws_cloudwatch_log_group" "cw_log_group" {
  count = var.enable_cw_log_group ? 1 : 0

  name              = var.cw_log_group_name != "" ? var.cw_log_group_name : "${lower(var.name)}-group-${lower(var.environment)}"
  retention_in_days = var.cw_log_group_retention_in_days
  kms_key_id        = var.cw_log_group_kms_key_id

  tags = merge(
    {
      Name = var.cw_log_group_name != "" ? var.cw_log_group_name : "${lower(var.name)}-group-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
