#---------------------------------------------------
# AWS secretsmanager secret version
#---------------------------------------------------
resource "aws_secretsmanager_secret_version" "secretsmanager_secret_version" {
    count                   = var.enable_secretsmanager_secret_version ? 1 : 0

    secret_id               = var.secretsmanager_secret_version_secret_id != "" && !var.enable_secretsmanager_secret ? var.secretsmanager_secret_version_secret_id : element(concat(aws_secretsmanager_secret.secretsmanager_secret.*.id, [""]), 0)

    secret_string           = var.secretsmanager_secret_version_secret_string
    secret_binary           = var.secretsmanager_secret_version_secret_binary
    version_stages          = var.secretsmanager_secret_version_version_stages

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on              = [
        aws_secretsmanager_secret.secretsmanager_secret
    ]
}
