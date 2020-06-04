#---------------------------------------------------
# AWS secretsmanager secret
#---------------------------------------------------
resource "aws_secretsmanager_secret" "secretsmanager_secret" {
    count                   = var.enable_secretsmanager_secret ? 1 : 0

    name                    = var.secretsmanager_secret_name != null && var.secretsmanager_secret_name_prefix == null ? lower(var.secretsmanager_secret_name) : null
    name_prefix             = var.secretsmanager_secret_name_prefix != null && var.secretsmanager_secret_name == null ? lower(var.secretsmanager_secret_name_prefix) : null
    description             = var.secretsmanager_secret_description
    kms_key_id              = var.secretsmanager_secret_kms_key_id
    policy                  = var.secretsmanager_secret_policy
    recovery_window_in_days = var.secretsmanager_secret_recovery_window_in_days
    rotation_lambda_arn     = var.secretsmanager_secret_rotation_lambda_arn

    dynamic "rotation_rules" {
        iterator = rotation_rules
        for_each = var.secretsmanager_secret_rotation_rules
        content {
            automatically_after_days = lookup(rotation_rules.value, "automatically_after_days", 30)
        }
    }

    tags                    = merge(
        {
            "Name"  = var.secretsmanager_secret_name != null && var.secretsmanager_secret_name_prefix == null ? lower(var.secretsmanager_secret_name) : lower(var.secretsmanager_secret_name_prefix)
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = []
}
