#-----------------------------------------------------------
# IAM account password policy
#-----------------------------------------------------------
resource "aws_iam_account_password_policy" "iam_account_password_policy" {
  count = var.enable_iam_account_password_policy ? 1 : 0

  minimum_password_length        = var.minimum_password_length
  require_lowercase_characters   = var.require_lowercase_characters
  require_uppercase_characters   = var.require_uppercase_characters
  require_numbers                = var.require_numbers
  require_symbols                = var.require_symbols
  allow_users_to_change_password = var.allow_users_to_change_password

  hard_expiry               = var.hard_expiry
  max_password_age          = var.max_password_age
  password_reuse_prevention = var.password_reuse_prevention

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
