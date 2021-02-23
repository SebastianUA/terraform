#-----------------------------------------------------------
# AWS SSM window task
#-----------------------------------------------------------
resource "aws_ssm_maintenance_window_task" "ssm_maintenance_window_task" {
  count = var.enable_ssm_maintenance_window_task ? 1 : 0

  name             = var.ssm_maintenance_window_task_name != "" ? lower(var.ssm_maintenance_window_task_name) : "${lower(var.name)}-mw-task-${lower(var.environment)}"
  description      = var.ssm_maintenance_window_task_description
  max_concurrency  = var.ssm_maintenance_window_task_max_concurrency
  max_errors       = var.ssm_maintenance_window_task_max_errors
  priority         = var.ssm_maintenance_window_task_priority
  service_role_arn = var.ssm_maintenance_window_task_service_role_arn
  task_arn         = var.ssm_maintenance_window_task_task_arn
  task_type        = upper(var.ssm_maintenance_window_task_task_type)
  window_id        = var.ssm_maintenance_window_task_window_id != "" ? var.ssm_maintenance_window_task_window_id : element(concat(aws_ssm_maintenance_window.ssm_maintenance_window.*.id, [""]), 0)

  dynamic "targets" {
    iterator = targets
    for_each = var.ssm_maintenance_window_task_targets
    content {
      key    = lookup(targets.value, "key", null)
      values = lookup(targets.value, "values", null)
    }
  }

  task_invocation_parameters {

    dynamic "automation_parameters" {
      iterator = automation_parameters
      for_each = length(var.ssm_maintenance_window_task_automation_parameters) > 0 ? [var.ssm_maintenance_window_task_automation_parameters] : []
      content {
        document_version = lookup(automation_parameters.value, "document_version", null)
        parameter {
          name   = lookup(automation_parameters.value, "name", null)
          values = lookup(automation_parameters.value, "values", null)
        }
      }
    }

    dynamic "lambda_parameters" {
      iterator = lambda_parameters
      for_each = length(var.ssm_maintenance_window_task_lambda_parameters) > 0 ? [var.ssm_maintenance_window_task_lambda_parameters] : []
      content {
        client_context = lookup(lambda_parameters.value, "client_context", null)
        payload        = lookup(lambda_parameters.value, "payload", null)
        qualifier      = lookup(lambda_parameters.value, "qualifier", null)
      }
    }

    dynamic "run_command_parameters" {
      iterator = run_command_parameters
      for_each = length(var.ssm_maintenance_window_task_run_command_parameters) > 0 ? [var.ssm_maintenance_window_task_run_command_parameters] : []
      content {
        comment              = lookup(run_command_parameters.value, "comment", null)
        document_hash        = lookup(run_command_parameters.value, "document_hash", null)
        document_hash_type   = lookup(run_command_parameters.value, "document_hash_type", null)
        output_s3_bucket     = lookup(run_command_parameters.value, "output_s3_bucket", null)
        output_s3_key_prefix = lookup(run_command_parameters.value, "output_s3_key_prefix", null)
        service_role_arn     = lookup(run_command_parameters.value, "service_role_arn", null)
        timeout_seconds      = lookup(run_command_parameters.value, "timeout_seconds", null)

        notification_config {
          notification_arn    = lookup(run_command_parameters.value, "notification_arn", null)
          notification_events = lookup(run_command_parameters.value, "notification_events", null)
          notification_type   = lookup(run_command_parameters.value, "notification_type", null)
        }

        parameter {
          name   = lookup(run_command_parameters.value, "name", null)
          values = lookup(run_command_parameters.value, "values", null)
        }

      }
    }

    dynamic "step_functions_parameters" {
      iterator = step_functions_parameters
      for_each = length(var.ssm_maintenance_window_task_lambda_parameters) > 0 ? [var.ssm_maintenance_window_task_lambda_parameters] : []
      content {
        input = lookup(step_functions_parameters.value, "input", null)
        name  = lookup(step_functions_parameters.value, "name", null)
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ssm_maintenance_window.ssm_maintenance_window
  ]
}
