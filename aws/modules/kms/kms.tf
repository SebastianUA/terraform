#---------------------------------------------------
# Create AWS KMS key
#---------------------------------------------------
resource "aws_kms_key" "kms_key" {
    description             = "${var.description}"
    deletion_window_in_days = "${var.deletion_window_in_days}"
    key_usage               = "${var.key_usage}"

    policy                  = "${data.template_file.kms_key_policy.rendered}"
    is_enabled              = "${var.is_enabled}"
    enable_key_rotation     = "${var.enable_key_rotation}"

    tags {
        Name            = "${lower(var.name)}-kms-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }
    
    lifecycle {
        create_before_destroy   = true
    }

    depends_on  = ["data.template_file.kms_key_policy"]
}

data "template_file" "kms_key_policy" {
    template = "${file("${path.module}/policies/kms_key_policy.json.tpl")}"
    
    vars {
        admin_user  = "${var.admin_user}"
        account_id  = "${var.aws_account_id}"
    }
}
#---------------------------------------------------
# Create AWS KMS alias for kms_key
#---------------------------------------------------
resource "aws_kms_alias" "kms_alias" {
    name            = "alias/${lower(var.name)}"
    target_key_id   = "${aws_kms_key.kms_key.key_id}"
    
    depends_on      = ["aws_kms_key.kms_key"]
}
