#-----------------------------------------------------------
# AWS IAM user ssh key
#-----------------------------------------------------------
resource "aws_iam_user_ssh_key" "iam_user_ssh_key" {
    count       = var.enable_iam_user_ssh_key ? 1 : 0

    username    = var.iam_user_ssh_key_username != "" && !var.enable_iam_user ? var.iam_user_ssh_key_username : element(concat(aws_iam_user.iam_user.*.name, [""]), 0)
    encoding    = upper(var.iam_user_ssh_key_encoding)
    public_key  = var.iam_user_ssh_key_public_key

    status      = var.iam_user_ssh_key_status

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = [
        aws_iam_user.iam_user
    ]
}
