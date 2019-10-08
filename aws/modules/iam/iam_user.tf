#-----------------------------------------------------------
# IAM user
#-----------------------------------------------------------
resource "aws_iam_user" "iam_user" {
    count                   = "${var.enable_iam_user ? 1 : 0}"

    name                    = "${var.iam_user_name != "" ? var.iam_user_name : "${lower(var.name)}-iam-user-${lower(var.environment)}" }"
    path                    = "${var.iam_user_path}"
                
    permissions_boundary    = "${var.permissions_boundary}"
    force_destroy           = "${var.force_destroy}"

    tags = {
        Name            = "${length(var.iam_role_name) > 0 ? var.iam_role_name : "${lower(var.name)}-iam-user-${lower(var.environment)}" }"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
}

#-----------------------------------------------------------
# IAM user policy
#-----------------------------------------------------------
resource "aws_iam_user_policy" "iam_user_policy" {
    count                   = "${var.enable_iam_user_policy ? 1 : 0}"

    name                    = "${var.iam_user_policy_name != "" ? var.iam_user_policy_name : "${lower(var.name)}-iam-user-policy-${lower(var.environment)}" }"
    user                    = "${var.iam_user_policy_user}"
    policy                  = "${var.iam_user_policy_policy}"
}

resource "aws_iam_user_policy" "iam_user_policy_name_prefix" {
    count                   = "${var.enable_iam_user_policy_name_prefix ? 1 : 0}"

    name_prefix             = "${var.iam_user_policy_name_prefix}"
    user                    = "${var.iam_user_policy_user}"
    policy                  = "${var.iam_user_policy_policy}"
}


#-----------------------------------------------------------
# IAM user policy attachment
#-----------------------------------------------------------
resource "aws_iam_user_policy_attachment" "iam_user_policy_attachment" {
    count                   = "${var.enable_iam_user_policy_attachment ? 1 : 0}"
    
    user                    = "${var.iam_user_policy_attachment_name}"
    policy_arn              = "${var.iam_user_policy_attachment_policy_arn}"
}
