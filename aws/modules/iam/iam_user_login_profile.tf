#-----------------------------------------------------------
# AWS IAM user login profile
#-----------------------------------------------------------
resource "aws_iam_user_login_profile" "iam_user_login_profile" {
    count                       = "${var.enable_iam_user_login_profile ? 1 : 0}"
                
    user                        = "${var.iam_user_login_profile_user}"
    pgp_key                     = "${var.iam_user_login_profile_pgp_key}"

    password_length             = "${var.iam_user_login_profile_password_length}"
    password_reset_required     = "${var.iam_user_login_profile_password_reset_required}"

    lifecycle {
        ignore_changes = ["password_length", "password_reset_required", "pgp_key"]
    }

    depends_on  = []    
}

