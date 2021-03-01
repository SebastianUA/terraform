#-----------------------------------------------------------
# IAM account password policy
#-----------------------------------------------------------
resource "aws_iam_account_password_policy" "iam_account_password_policy" {
  count = var.enable_iam_account_password_policy ? 1 : 0

  minimum_password_length        = var.iam_account_password_policy_minimum_password_length
  require_lowercase_characters   = var.iam_account_password_policy_require_lowercase_characters
  require_uppercase_characters   = var.iam_account_password_policy_require_uppercase_characters
  require_numbers                = var.iam_account_password_policy_require_numbers
  require_symbols                = var.iam_account_password_policy_require_symbols
  allow_users_to_change_password = var.iam_account_password_policy_allow_users_to_change_password

  hard_expiry               = var.iam_account_password_policy_hard_expiry
  max_password_age          = var.iam_account_password_policy_max_password_age
  password_reuse_prevention = var.iam_account_password_policy_password_reuse_prevention

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
