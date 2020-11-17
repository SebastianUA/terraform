#-----------------------------------------------------------
# IAM account alias
#-----------------------------------------------------------
resource "aws_iam_account_alias" "iam_account_alias" {
  count = var.enable_iam_account_alias ? 1 : 0

  account_alias = var.account_alias != "" ? var.account_alias : "${lower(var.name)}-acc-alias-${lower(var.environment)}"

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
