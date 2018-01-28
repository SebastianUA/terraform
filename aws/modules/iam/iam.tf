#---------------------------------------------------
# Instance Profile
#---------------------------------------------------
resource "aws_iam_instance_profile" "profile" {
    name        = "${var.name}-profile-${var.environment}"
    role        = "${aws_iam_role.role.name}"
}
#----------------------------------------------------
# IAM Role
#----------------------------------------------------
resource "aws_iam_role" "role" {
    name                = "${var.name}-role-${var.environment}"
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
#----------------------------------------------------
# IAM Policy
#----------------------------------------------------
resource "aws_iam_policy" "policy" {
    name        = "${var.name}-policy-${var.environment}"
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
#resource "aws_iam_policy" "test-policy" {
#    name        = "test-policy"
#    description = "AIM test-policy policy"
#    policy      = "${file(policies/assume_role_policy.json)}"
#    
#}       
#----------------------------------------------------
# IAM Policy Attachment
#----------------------------------------------------
resource "aws_iam_policy_attachment" "iam_policy_attachment" {
    name        = "${var.name}-iam_policy_attachment-${var.environment}"
    roles       = ["${aws_iam_role.role.name}"]
    policy_arn  = "${aws_iam_policy.policy.arn}"
}

