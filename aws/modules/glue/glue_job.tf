#---------------------------------------------------
# AWS Glue job
#---------------------------------------------------
resource "aws_glue_job" "glue_job" {
  count = var.enable_glue_job ? 1 : 0

  name     = var.glue_job_name != "" ? lower(var.glue_job_name) : "${lower(var.name)}-glue-job-${lower(var.environment)}"
  role_arn = var.glue_job_role_arn

  description            = var.glue_job_description
  connections            = length(var.glue_job_connections) > 0 && !var.enable_glue_connection ? var.glue_job_connections : concat(var.glue_job_additional_connections, [element(concat(aws_glue_connection.glue_connection.*.id, [""]), 0)])
  default_arguments      = var.glue_job_default_arguments
  glue_version           = var.glue_job_glue_version
  max_capacity           = var.glue_job_max_capacity
  max_retries            = var.glue_job_max_retries
  timeout                = var.glue_job_timeout
  security_configuration = var.glue_job_security_configuration != "" && !var.enable_glue_security_configuration ? var.glue_job_security_configuration : element(concat(aws_glue_security_configuration.glue_security_configuration.*.id, [""]), 0)
  worker_type            = var.glue_job_worker_type
  number_of_workers      = var.glue_job_number_of_workers

  dynamic "command" {
    iterator = command
    for_each = var.glue_job_command

    content {
      script_location = lookup(command.value, "script_location", null)

      name           = lookup(command.value, "name", null)
      python_version = lookup(command.value, "python_version", null)
    }
  }

  dynamic "execution_property" {
    iterator = execution_property
    for_each = var.glue_job_execution_property

    content {
      max_concurrent_runs = lookup(execution_property.value, "max_concurrent_runs", 1)
    }
  }

  dynamic "notification_property" {
    iterator = notification_property
    for_each = var.glue_job_notification_property

    content {
      notify_delay_after = lookup(notification_property.value, "notify_delay_after", null)
    }
  }

  tags = merge(
    {
      Name = var.glue_job_name != "" ? lower(var.glue_job_name) : "${lower(var.name)}-glue-job-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_glue_connection.glue_connection,
    aws_glue_security_configuration.glue_security_configuration
  ]
}
