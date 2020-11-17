#---------------------------------------------------
# AWS config aggregate authorization
#---------------------------------------------------
resource "aws_config_aggregate_authorization" "config_aggregate_authorization" {
  count = var.enable_config_aggregate_authorization ? 1 : 0

  account_id = var.config_aggregate_authorization_account_id
  region     = var.region

  tags = merge(
    {
      "Name" = var.config_aggregate_authorization_name != "" ? lower(var.config_aggregate_authorization_name) : "${lower(var.name)}-config-aggregate-auth-${lower(var.environment)}"
    },
    var.tags,
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
