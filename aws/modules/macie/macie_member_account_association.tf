#---------------------------------------------------
# AWS macie member account association
#---------------------------------------------------
resource "aws_macie_member_account_association" "macie_member_account_association" {
  count = var.enable_macie_member_account_association ? 1 : 0

  member_account_id = var.macie_member_account_association_member_account_id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
