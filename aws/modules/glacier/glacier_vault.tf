#---------------------------------------------------
# AWS glacier vault
#---------------------------------------------------
resource "aws_glacier_vault" "glacier_vault" {
  count = var.enable_glacier_vault ? 1 : 0

  name = var.glacier_vault_name != "" ? lower(var.glacier_vault_name) : "${lower(var.name)}-glacier-vault-${lower(var.environment)}"

  access_policy = var.glacier_vault_access_policy

  dynamic "notification" {
    iterator = notification
    for_each = var.glacier_vault_notification
    content {
      sns_topic = lookup(notification.value, "sns_topic", null)
      events    = lookup(notification.value, "events", null)
    }
  }

  tags = merge(
    {
      Name = var.glacier_vault_name != "" ? lower(var.glacier_vault_name) : "${lower(var.name)}-glacier-vault-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
