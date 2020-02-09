#-----------------------------------------------------------
# IAM role policy attachment
#-----------------------------------------------------------
resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
    count               = var.enable_iam_role_policy_attachment ? length(var.policy_arns) : 0

    role                = var.iam_role_policy_role != "" ? var.iam_role_policy_role : element(concat(aws_iam_role.iam_role.*.name, [""]), 0)
    policy_arn          = var.policy_arns[count.index]
    
    depends_on          = [
        aws_iam_role.iam_role
    ]
}