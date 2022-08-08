#---------------------------------------------------
# AWS dms replication task
#---------------------------------------------------
resource "aws_dms_replication_task" "dms_replication_task" {
  for_each = { for k, v in var.dms_replication_tasks : k => v if var.enable_dms_replication_task }

  replication_task_id = lookup(each.value, "replication_task_id", "${lower(var.name)}-dms-replication-task-${lower(var.environment)}")
  # lookup(each.value, "replication_task_id", "${lower(var.name)}-dms-replication-task-${lower(var.environment)}-${each.key + 1}")
  migration_type           = lookup(each.value, "migration_type", null)
  replication_instance_arn = lookup(each.value, "replication_instance_arn", (var.enable_dms_replication_instance ? aws_dms_replication_instance.dms_replication_instance[0].replication_instance_arn : null))
  source_endpoint_arn      = lookup(each.value, "source_endpoint_arn", aws_dms_endpoint.dms_endpoint[each.value.source_endpoint_key].endpoint_arn)
  # (var.enable_dms_endpoint ? aws_dms_endpoint.dms_endpoint[count.index].endpoint_arn : null)
  target_endpoint_arn = lookup(each.value, "target_endpoint_arn", aws_dms_endpoint.dms_endpoint[each.value.target_endpoint_key].endpoint_arn)
  table_mappings      = lookup(each.value, "table_mappings", null)

  cdc_start_time            = lookup(each.value, "cdc_start_time", null)
  replication_task_settings = lookup(each.value, "replication_task_settings", null)

  tags = merge(
    {
      Name = lookup(each.value, "endpoint_id", "${lower(var.name)}-dms-replication-task-${lower(var.environment)}-${replace(each.key, "_", "-")}")
    },
    var.tags,
    lookup(each.value, "tags", {})
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      replication_task_settings
    ]
  }

  depends_on = [
    aws_dms_replication_instance.dms_replication_instance,
    aws_dms_endpoint.dms_endpoint
  ]
}