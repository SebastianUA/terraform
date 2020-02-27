#-----------------------------------------------------------
# IAM Policy
#-----------------------------------------------------------
resource "aws_iam_policy" "iam_policy" {
    count       = var.enable_iam_policy ? 1 : 0

    name        = var.iam_policy_name != "" && var.iam_policy_name_prefix == "" ? lower(var.iam_policy_name) : null
    name_prefix = var.iam_policy_name_prefix != "" && var.iam_policy_name == "" ? lower(var.iam_policy_name_prefix) : null
    description = var.iam_policy_description != "" ? var.iam_policy_description : null

    path        = var.iam_policy_path
    policy      = var.iam_policy_policy

    depends_on  = []
}
