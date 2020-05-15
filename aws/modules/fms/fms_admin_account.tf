#---------------------------------------------------
# AWS fms admin account
#---------------------------------------------------
resource "aws_fms_admin_account" "fms_admin_account" {
    count               = var.enable_fms_admin_account ? 1 : 0

    account_id          = var.fms_admin_account_id

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = []
}
