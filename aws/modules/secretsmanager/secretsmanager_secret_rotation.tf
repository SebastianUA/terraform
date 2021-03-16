#---------------------------------------------------
# AWS secretsmanager secret rotation
#---------------------------------------------------
resource "aws_secretsmanager_secret_rotation" "secretsmanager_secret_rotation" {
  count = var.enable_secretsmanager_secret_rotation ? 1 : 0

  secret_id           = var.secretsmanager_secret_rotation_secret_id != "" && !var.enable_secretsmanager_secret ? var.secretsmanager_secret_rotation_secret_id : (var.enable_secretsmanager_secret ? element(aws_secretsmanager_secret.secretsmanager_secret.*.id, 0) : null)
  rotation_lambda_arn = var.secretsmanager_secret_rotation_rotation_lambda_arn

  rotation_rules {
    automatically_after_days = var.secretsmanager_secret_rotation_rotation_rules_automatically_after_days
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_secretsmanager_secret.secretsmanager_secret
  ]
}