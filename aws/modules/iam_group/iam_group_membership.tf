#-----------------------------------------------------------
# IAM group membership
#-----------------------------------------------------------
resource "aws_iam_group_membership" "iam_group_membership" {
    count       = var.enable_iam_group_membership ? 1 : 0

    name        = var.iam_group_membership_name != "" ? lower(var.iam_group_membership_name) : "${lower(var.name)}-group-membership-${lower(var.environment)}"

    users       = var.iam_group_membership_users
    group       = var.iam_group_policy_group != "" && !var.enable_iam_group ? var.iam_group_policy_group : element(concat(aws_iam_group.iam_group.*.name, [""]), 0)

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on  = [
        aws_iam_group.iam_group
    ]
}