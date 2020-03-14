#-----------------------------------------------------------
# AWS IAM user ssh key
#-----------------------------------------------------------
resource "aws_iam_access_key" "iam_access_key" {
    count       = var.enable_iam_access_key ? 1 : 0

    status      = var.iam_access_key_status

    # If you need IAM access key
    pgp_key     = var.iam_access_key_pgp_key != null ? var.iam_access_key_pgp_key : null
    # If you need IAM access key with no_pgp
    user        = var.iam_access_key_user != null ? var.iam_access_key_user : null

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = []
}
