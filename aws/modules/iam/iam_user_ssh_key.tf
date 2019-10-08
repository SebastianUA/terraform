#-----------------------------------------------------------
# AWS IAM user ssh key
#-----------------------------------------------------------
resource "aws_iam_user_ssh_key" "iam_user_ssh_key" {
    count       = "${var.enable_iam_user_ssh_key ? 1 : 0}"
    
    username    = "${var.iam_user_ssh_key_username}"
    encoding    = "${upper(var.iam_user_ssh_key_encoding)}"
    public_key  = "${var.iam_user_ssh_key_public_key}"

    status      = "${var.iam_user_ssh_key_status}"

    depends_on  = []
}
