#-----------------------------------------------------------
# IAM group policy attachment
#-----------------------------------------------------------
resource "aws_iam_group_policy_attachment" "iam_group_policy_attachment" {
    count           = var.enable_iam_group_policy_attachment ? 1 : 0

    group           = var.iam_group_policy_group != "" && !var.enable_iam_group ? var.iam_group_policy_group : element(concat(aws_iam_group.iam_group.*.name, [""]), 0)
    policy_arn      = var.iam_group_policy_attachment_policy_arn

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on      = [
        aws_iam_group.iam_group
    ]
}