#---------------------------------------------------
# AWS dms replication task
#---------------------------------------------------
resource "aws_dms_replication_task" "dms_replication_task" {
  count = var.enable_dms_replication_task ? 1 : 0

  migration_type           = var.dms_replication_task_migration_type
  replication_instance_arn = var.dms_replication_task_replication_instance_arn != "" ? var.dms_replication_task_replication_instance_arn : (var.enable_dms_replication_instance ? aws_dms_replication_instance.dms_replication_instance[count.index].replication_instance_arn : null)
  replication_task_id      = var.dms_replication_task_replication_task_id
  source_endpoint_arn      = var.dms_replication_task_source_endpoint_arn != "" ? var.dms_replication_task_source_endpoint_arn : (var.enable_dms_endpoint ? aws_dms_endpoint.dms_endpoint[count.index].endpoint_arn : null)
  target_endpoint_arn      = var.dms_replication_task_target_endpoint_arn
  table_mappings           = var.dms_replication_task_table_mappings

  cdc_start_time            = var.dms_replication_task_cdc_start_time
  replication_task_settings = var.dms_replication_task_replication_task_settings

  tags = merge(
    {
      Name = var.dms_replication_task_replication_task_id != "" ? lower(var.dms_replication_task_replication_task_id) : "${lower(var.name)}-dms-replication-task-${lower(var.environment)}"
    },
    var.tags
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