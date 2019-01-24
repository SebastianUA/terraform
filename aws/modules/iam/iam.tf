#-----------------------------------------------------------
# IAM Role
#-----------------------------------------------------------
resource "aws_iam_role" "iam_role" {
    count                   = "${var.enable_iam_role ? 1 : 0}"
                            
    name                    = "${length(var.iam_role_name) > 0 ? var.iam_role_name : "${lower(var.name)}-iam_role-${lower(var.environment)}" }"
    # name_prefix conflicts with name; I'm using name for iam role
    #name_prefix             = ""
    description             = "IMA role created by ${var.orchestration}"
    
    assume_role_policy      = "${file("${var.assume_role_policy_file}")}"
    force_detach_policies   = "${var.iam_role_force_detach_policies}"
    path                    = "${var.iam_role_path}"
    max_session_duration    = "${var.iam_role_max_session_duration}"
    permissions_boundary    = "${var.iam_role_permissions_boundary}"

    tags {
        Name            = "${length(var.iam_role_name) > 0 ? var.iam_role_name : "${lower(var.name)}-iam_role-${lower(var.environment)}" }"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }        

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = ["tags"]
    } 
    
    depends_on  = []

}
#-----------------------------------------------------------
# IAM user
#-----------------------------------------------------------

#-----------------------------------------------------------
# IAM group
#-----------------------------------------------------------

#-----------------------------------------------------------
# Instance Profile
#-----------------------------------------------------------
resource "aws_iam_instance_profile" "iam_instance_profile" {
    count       = "${var.enable_iam_instance_profile ? 1 : 0}"

    name        = "${length(var.iam_instance_profile_name) > 0 ? var.iam_instance_profile_name : "${lower(var.name)}-iam_instance_profile-${lower(var.environment)}" }"
    role        = "${length(var.iam_instance_profile_role) == 0 &&  var.enable_iam_role ? "${aws_iam_role.iam_role.name}" : "${var.iam_instance_profile_role}" }"

    lifecycle = {
        create_before_destroy   = true,
        ignore_changes          = []
    }

    depends_on  = ["aws_iam_role.iam_role"]
}
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
#-----------------------------------------------------------
# Create AWS IAM server certificate
#-----------------------------------------------------------
resource "aws_iam_server_certificate" "iam_server_certificate" {
    count            = "${var.enable_iam_server_certificate ? 1 : 0}"

    name             = "${length(var.iam_server_certificate_name) > 0 ? var.iam_server_certificate_name : "${lower(var.name)}-certificate-${lower(var.environment)}" }"
    certificate_body = "${file("${var.certificate_body_file}")}"
    private_key      = "${file("${var.private_key_file}")}"
                        
    lifecycle {
        create_before_destroy = true,
        ignore_changes          = []
    }

    depends_on  = []
}
