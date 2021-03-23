#---------------------------------------------------
# ssoadmin account assignment
#---------------------------------------------------
resource "aws_ssoadmin_account_assignment" "ssoadmin_account_assignment" {
  count = var.enable_ssoadmin_account_assignment ? 1 : 0

  instance_arn       = var.ssoadmin_account_assignment_instance_arn
  permission_set_arn = var.ssoadmin_account_assignment_permission_set_arn

  principal_id   = var.ssoadmin_account_assignment_principal_id
  principal_type = var.ssoadmin_account_assignment_principal_type

  target_id   = var.ssoadmin_account_assignment_target_id
  target_type = var.ssoadmin_account_assignment_target_type

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
