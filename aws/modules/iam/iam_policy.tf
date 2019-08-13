#-----------------------------------------------------------
# IAM Policy
#-----------------------------------------------------------
resource "aws_iam_policy" "iam_policy" {
    count       = "${var.enable_iam_policy ? 1 : 0 }"

    name        = "${length(var.iam_policy_name) > 0 ? var.iam_policy_name : "${lower(var.name)}-iam_policy-${lower(var.environment)}" }"
    description = "AIM ${var.name}-policy-${var.environment} policy"

    path        = "${var.iam_policy_path}"
    policy      = "${var.iam_policy_policy}"

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }
    
    depends_on  = []
}

resource "aws_iam_policy" "iam_policy_name_prefix" {
    count       = "${var.iam_policy_name_prefix ? 1 : 0 }"
    
    name_prefix = ""
    description = "AIM ${var.name}-policy-${var.environment} policy"

    path        = "${var.iam_policy_path}"
    policy      = "${var.iam_policy_policy}"

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }
    
    depends_on  = []
}

####################################################
# IAM Policy Attachment
####################################################
resource "aws_iam_policy_attachment" "iam_policy_attachment" {
    count       = "${var.enable_iam_policy_attachment ? 1 : 0}"

    name        = "${length(var.iam_policy_attachment_name) > 0 ? var.iam_policy_attachment_name : "${lower(var.name)}-iam_policy_attachment-${lower(var.environment)}" }"
    roles       = ["${var.iam_role_policy_attachment_role}"]
    users       = []
    groups      = []
    policy_arn  = "${var.iam_role_policy_attachment_policy_arn}"
}
