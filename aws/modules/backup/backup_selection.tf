#---------------------------------------------------
# AWS Backup selection
#---------------------------------------------------
resource "aws_backup_selection" "backup_selection" {
  count = var.enable_backup_selection ? 1 : 0

  name         = var.backup_selection_name != "" ? lower(var.backup_selection_name) : "${lower(var.name)}-backup-selection-${lower(var.environment)}"
  iam_role_arn = var.backup_selection_iam_role_arn
  plan_id      = var.backup_selection_plan_id != "" && !var.enable_backup_plan ? var.backup_selection_plan_id : element(concat(aws_backup_plan.backup_plan.*.id, [""]), 0)

  resources = var.backup_selection_resources

  dynamic "selection_tag" {
    iterator = selection_tag
    for_each = var.backup_selection_selection_tag

    content {
      type  = lookup(selection_tag.value, "type", null)
      key   = lookup(selection_tag.value, "key", null)
      value = lookup(selection_tag.value, "value", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_backup_plan.backup_plan
  ]
}
