#---------------------------------------------------
# AWS secretsmanager secret policy
#---------------------------------------------------
resource "aws_secretsmanager_secret_policy" "secretsmanager_secret_policy" {
  count = var.enable_secretsmanager_secret_policy ? 1 : 0

  secret_arn = var.secretsmanager_secret_policy_secret_arn != "" && !var.enable_secretsmanager_secret ? var.secretsmanager_secret_policy_secret_arn : (var.enable_secretsmanager_secret ? element(aws_secretsmanager_secret.secretsmanager_secret.*.arn, 0) : null)
  policy     = var.secretsmanager_secret_policy_policy

  block_public_policy = var.secretsmanager_secret_policy_block_public_policy

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_secretsmanager_secret.secretsmanager_secret
  ]
}