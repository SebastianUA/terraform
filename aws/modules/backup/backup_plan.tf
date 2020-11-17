#---------------------------------------------------
# AWS Backup plan
#---------------------------------------------------
resource "aws_backup_plan" "backup_plan" {
  count = var.enable_backup_plan ? 1 : 0

  name = var.backup_plan_name != "" ? lower(var.backup_plan_name) : "${lower(var.name)}-backup-plan-${lower(var.environment)}"

  dynamic "rule" {
    iterator = rule
    for_each = var.backup_plan_rule
    content {
      rule_name         = lookup(rule.value, "rule_name", null)
      target_vault_name = lookup(rule.value, "target_vault_name", element(concat(aws_backup_vault.backup_vault.*.name, [""]), 0))

      schedule            = lookup(rule.value, "schedule", null)
      start_window        = lookup(rule.value, "start_window", null)
      completion_window   = lookup(rule.value, "completion_window", null)
      recovery_point_tags = lookup(rule.value, "recovery_point_tags", null)

      lifecycle {
        cold_storage_after = lookup(rule.value, "cold_storage_after", null)
        delete_after       = lookup(rule.value, "delete_after", null)
      }
    }
  }

  dynamic "rule" {
    iterator = rule
    for_each = var.backup_plan_rule_copy_action
    content {
      rule_name         = lookup(rule.value, "rule_name", null)
      target_vault_name = lookup(rule.value, "target_vault_name", element(concat(aws_backup_vault.backup_vault.*.name, [""]), 0))

      schedule            = lookup(rule.value, "schedule", null)
      start_window        = lookup(rule.value, "start_window", null)
      completion_window   = lookup(rule.value, "completion_window", null)
      recovery_point_tags = lookup(rule.value, "recovery_point_tags", null)

      lifecycle {
        cold_storage_after = lookup(rule.value, "cold_storage_after", null)
        delete_after       = lookup(rule.value, "delete_after", null)
      }

      copy_action {
        destination_vault_arn = lookup(rule.value, "destination_vault_arn", null)

        lifecycle {
          cold_storage_after = lookup(rule.value, "copy_action_lifecycle_cold_storage_after", null)
          delete_after       = lookup(rule.value, "copy_action_lifecycle_delete_after", null)
        }
      }
    }
  }

  tags = merge(
    {
      "Name" = var.backup_plan_name != "" ? lower(var.backup_plan_name) : "${lower(var.name)}-backup-plan-${lower(var.environment)}"
    },
    var.tags,
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_backup_vault.backup_vault
  ]
}
