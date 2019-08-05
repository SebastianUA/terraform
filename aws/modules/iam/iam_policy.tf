#-----------------------------------------------------------
# IAM Policy
#-----------------------------------------------------------
resource "aws_iam_policy" "iam_policy" {
    count       = "${var.enable_iam_policy ? 1 : 0 }"

    name        = "${length(var.iam_policy_name) > 0 ? var.iam_policy_name : "${lower(var.name)}-iam_policy-${lower(var.environment)}" }"
    # name_prefix conflicts with name;
    # name_prefix = ""
    description = "AIM ${var.name}-policy-${var.environment} policy"

    path        = "${var.iam_policy_path}"
    policy      = "${file("${var.iam_policy_file}")}"

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
    roles       = ["${length(var.iam_role_name) > 0 ? "${var.iam_role_name}" : "${aws_iam_role.iam_role.name}" }"]
    users       = []
    groups      = []
    policy_arn  = "${aws_iam_policy.iam_policy.arn}"
}
