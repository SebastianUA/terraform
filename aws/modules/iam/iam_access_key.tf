#-----------------------------------------------------------
# AWS IAM user ssh key
#-----------------------------------------------------------
resource "aws_iam_access_key" "iam_access_key" {
    count       = "${var.enable_iam_access_key && var.iam_access_key_pgp_key != "" ? 1 : 0}"
    
    user        = "${var.iam_access_key_user}"
    pgp_key     = "${var.iam_access_key_pgp_key}"

    #status      = "${var.iam_access_key_status}"

    depends_on  = []
}

resource "aws_iam_access_key" "iam_access_key_no_pgp" {
    count       = "${var.enable_iam_access_key && var.iam_access_key_pgp_key == "" ? 1 : 0}"
    
    user        = "${var.iam_access_key_user}"

    depends_on  = []
}
