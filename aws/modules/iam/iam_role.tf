#-----------------------------------------------------------
# IAM Role
#-----------------------------------------------------------
resource "aws_iam_role" "iam_role" {
    count                   = "${var.enable_iam_role ? 1 : 0}"
                            
    name                    = "${length(var.iam_role_name) > 0 ? var.iam_role_name : "${lower(var.name)}-iam_role-${lower(var.environment)}" }"
    # name_prefix conflicts with name; I'm using name for iam role
    #name_prefix             = ""
    description             = "IMA role created by ${var.orchestration}"
    
    assume_role_policy      = "${var.assume_role_policy}"
    force_detach_policies   = "${var.iam_role_force_detach_policies}"
    path                    = "${var.iam_role_path}"
    #max_session_duration    = "${var.iam_role_max_session_duration}"
    #permissions_boundary    = "${var.iam_role_permissions_boundary}"

    #tags {
    #    Name            = "${length(var.iam_role_name) > 0 ? var.iam_role_name : "${lower(var.name)}-iam_role-${lower(var.environment)}" }"
    #    Environment     = "${var.environment}"
    #    Orchestration   = "${var.orchestration}"
    #    Createdby       = "${var.createdby}"
    #}        

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = ["tags"]
    } 
    
    depends_on  = []

}

#-----------------------------------------------------------
# IAM role policy attachment
#-----------------------------------------------------------
resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
    count      = "${var.enable_iam_role_policy_attachment ? 1 : 0}"

    role       = "${var.iam_role_policy_attachment_role}"
    policy_arn = "${var.iam_role_policy_attachment_policy_arn}"
    
    depends_on = []
}


#-----------------------------------------------------------
# EC2 Policy Assuming Crossaccount Role
#-----------------------------------------------------------
resource "aws_iam_role" "cross_account_assume_role" {
    count               = "${var.enable_crossaccount_role ? 1 : 0}"
    
    name                = "${length(var.cross_account_assume_role_name) > 0 ? var.cross_account_assume_role_name : "${lower(var.name)}-cross_account_assume_role-${lower(var.environment)}" }"
    description         = "IMA cross account assume role" 
    assume_role_policy  = "${data.aws_iam_policy_document.cross_account_assume_role_policy.json}"

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = ["data.aws_iam_policy_document.cross_account_assume_role_policy"]
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
# Attachment Assuming Crossaccount Role
####################################################
resource "aws_iam_role_policy_attachment" "cross_account_assume_role" {
    count      = "${var.enable_crossaccount_role ? length(var.cross_acc_policy_arns) : 0}"

    role       = "${aws_iam_role.cross_account_assume_role.name}"
    policy_arn = "${element(var.cross_acc_policy_arns, count.index)}"
    
    depends_on = ["aws_iam_role.cross_account_assume_role"]
}
