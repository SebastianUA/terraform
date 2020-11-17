#---------------------------------------------------
# AWS Batch job definition
#---------------------------------------------------
resource "aws_batch_job_definition" "batch_job_definition" {
  count = var.enable_batch_job_definition ? 1 : 0

  name = var.batch_job_definition_name != "" ? lower(var.batch_job_definition_name) : "${lower(var.name)}-batch-job-definition-${lower(var.environment)}"
  type = lower(var.batch_job_definition_type)

  container_properties = var.batch_job_definition_container_properties
  parameters           = var.batch_job_definition_parameters

  dynamic "retry_strategy" {
    iterator = retry_strategy
    for_each = var.batch_job_definition_retry_strategy
    content {
      attempts = lookup(retry_strategy.value, "attempts", null)
    }
  }

  dynamic "timeout" {
    iterator = timeout
    for_each = var.batch_job_definition_timeout
    content {
      attempt_duration_seconds = lookup(timeout.value, "attempt_duration_seconds", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
