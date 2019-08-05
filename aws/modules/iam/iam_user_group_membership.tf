#-----------------------------------------------------------
# IAM iam user group membership
#-----------------------------------------------------------
resource "aws_iam_user_group_membership" "iam_user_group_membership" {
    count       = "${var.enable_iam_user_group_membership ? 1 : 0}"
    
    user        = "${var.iam_user_group_membership_user}"
    groups      = ["${var.iam_user_group_membership_groups}"]

    lifecycle {
        ignore_changes = []
    }

    depends_on  = []
}
