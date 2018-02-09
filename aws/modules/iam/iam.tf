####################################################
# Instance Profile
####################################################
resource "aws_iam_instance_profile" "iam_instance_profile" {
    name        = "${lower(var.name)}-iam_instance_profile-${lower(var.environment)}"
    role        = "${aws_iam_role.iam_role.name}"
    
    depends_on  = ["aws_iam_role.iam_role"]
}
####################################################
# IAM Role
####################################################
resource "aws_iam_role" "iam_role" {
    name                = "${lower(var.name)}-iam_role-${lower(var.environment)}"
    description         = "IMA ${var.name}-role-${var.environment} role"
    path                = "/"
    assume_role_policy  = "${data.aws_iam_policy_document.role-policy-document.json}"
}
data "aws_iam_policy_document" "role-policy-document" {
  "statement" {
    effect = "Allow"

    principals {
      identifiers = [
        "${var.aws_iam_role-principals}",
      ]

      type = "Service"
    }

    actions = [
        "sts:AssumeRole",
    ]
  }
}
####################################################
# IAM Policy
####################################################
resource "aws_iam_policy" "iam_policy" {
    name        = "${lower(var.name)}-iam_policy-${lower(var.environment)}"
    description = "AIM ${var.name}-policy-${var.environment} policy"
    policy      = "${data.aws_iam_policy_document.policy-document.json}" 
}
data "aws_iam_policy_document" "policy-document" {
  "statement" {
    effect = "Allow"

    resources = [
      "${var.aws_iam_policy-resources}",
    ]

    actions = [
      "${var.aws_iam_policy-actions}",
    ]
  }
}
#resource "aws_iam_policy" "iam_policy" {
#    name        = "${lower(var.name)}-iam_policy-${lower(var.environment)}"
#    description = "AIM ${var.name}-policy-${var.environment} policy"
#    policy      = "${file(${path.module}/policies/assume_role_policy.json)}"
#    
#}
####################################################
# EC2 Policy Assuming Crossaccount Role
####################################################
resource "aws_iam_role" "cross_account_assume_role" {
    count              = "${var.enable_crossaccount_role ? 1 : 0}"
    
    name               = "${var.name}-cross_account_assume_role-${var.environment}"
    description        = "IMA ${var.name}-cross_account_assume_role-${var.environment} role" 
    assume_role_policy = "${data.aws_iam_policy_document.cross_account_assume_role_policy.json}"
}

data "aws_iam_policy_document" "cross_account_assume_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["${var.cross_acc_principal_arns}"]
    }
    actions = ["sts:AssumeRole"]
  }
}
####################################################
# IAM Policy Attachment
####################################################
resource "aws_iam_policy_attachment" "iam_policy_attachment" {
    name        = "${lower(var.name)}-iam_policy_attachment-${lower(var.environment)}"
    roles       = ["${aws_iam_role.iam_role.name}"]
    policy_arn  = "${aws_iam_policy.iam_policy.arn}"
}
####################################################
# Attachment Assuming Crossaccount Role
####################################################
resource "aws_iam_role_policy_attachment" "cross_account_assume_role" {
    count      = "${var.enable_crossaccount_role ? length(var.cross_acc_policy_arns) : 0}"

    role       = "${aws_iam_role.cross_account_assume_role.name}"
    policy_arn = "${element(var.cross_acc_policy_arns, count.index)}"
    
    depends_on = ["aws_iam_role.cross_account_assume_role"]
}
