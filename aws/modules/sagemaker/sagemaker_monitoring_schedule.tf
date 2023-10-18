#---------------------------------------------------
# AWS Sagemaker monitoring schedule
#---------------------------------------------------
resource "aws_sagemaker_monitoring_schedule" "sagemaker_monitoring_schedule" {
  count = var.enable_sagemaker_monitoring_schedule ? 1 : 0

  name = var.sagemaker_monitoring_schedule_name != "" ? var.sagemaker_monitoring_schedule_name : "${lower(var.name)}-monitoring-schedule-${lower(var.environment)}"

  dynamic "monitoring_schedule_config" {
    iterator = monitoring_schedule_config
    for_each = var.sagemaker_monitoring_schedule_config

    content {
      monitoring_job_definition_name = lookup(monitoring_schedule_config.value, "monitoring_job_definition_name", null)
      monitoring_type                = lookup(monitoring_schedule_config.value, "monitoring_type", null)

      dynamic "schedule_config" {
        iterator = schedule_config
        for_each = length(keys(lookup(monitoring_schedule_config.value, "schedule_config", {}))) > 0 ? [lookup(monitoring_schedule_config.value, "schedule_config", {})] : []

        content {
          schedule_expression = lookup(schedule_config.value, "schedule_expression", null)
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.sagemaker_monitoring_schedule_name != "" ? var.sagemaker_monitoring_schedule_name : "${lower(var.name)}-monitoring-schedule-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
