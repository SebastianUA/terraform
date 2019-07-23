#---------------------------------------------------
# Create AWS KMS key
#---------------------------------------------------
resource "aws_kms_key" "kms_key_default" {
    count                   = "${var.kms_key_default && !var.kms_key ? 1 : 0}"

    description             = "${var.description}"
    deletion_window_in_days = "${var.deletion_window_in_days}"

    is_enabled              = "${var.is_enabled}"
    enable_key_rotation     = "${var.enable_key_rotation}"

    tags {
        Name            = "${lower(var.name)}-kms-default-${lower(var.environment)}"
        Environment     = "${var.environment}"
        Orchestration   = "${var.orchestration}"
        Createdby       = "${var.createdby}"
    }

    lifecycle {
        create_before_destroy   = true
    }

    depends_on  = []
}


resource "aws_kms_key" "kms_key" {
    count                   = "${!var.kms_key_default && var.kms_key ? 1 : 0}"

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
    count                   = "${!var.kms_key_default && var.kms_key ? 1 : 0}"

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
    count           = "${var.kms_alias ? 1 : 0}"
                        
    name            = "alias/${lower(var.name)}"
    target_key_id   = "${var.target_key_id}"
    
    depends_on      = []
}

resource "aws_kms_alias" "kms_alias_prefix" {
    count           = "${var.kms_alias_prefix ? 1 : 0}"
                        
    name_prefix     = "${var.name_prefix}"
    target_key_id   = "${var.target_key_id}"
    
    depends_on      = []
}
