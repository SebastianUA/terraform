#-----------------------------------------------------------
# AWS IAM user login profile
#-----------------------------------------------------------
resource "aws_iam_user_login_profile" "iam_user_login_profile" {
  count = var.enable_iam_user_login_profile ? 1 : 0

  user    = var.iam_user_login_profile_user != "" && ! var.enable_iam_user ? var.iam_user_login_profile_user : element(concat(aws_iam_user.iam_user.*.name, [""]), 0)
  pgp_key = var.iam_user_login_profile_pgp_key

  password_length         = var.iam_user_login_profile_password_length
  password_reset_required = var.iam_user_login_profile_password_reset_required

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_iam_user.iam_user
  ]
}
