#---------------------------------------------------
# AWS opsworks user profile
#---------------------------------------------------
resource "aws_opsworks_user_profile" "opsworks_user_profile" {
  count = var.enable_opsworks_user_profile ? 1 : 0

  user_arn     = var.opsworks_user_profile_user_arn
  ssh_username = var.opsworks_user_profile_ssh_username

  allow_self_management = var.opsworks_user_profile_allow_self_management
  ssh_public_key        = var.opsworks_user_profile_ssh_public_key

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
