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

  dynamic "task_invocation_parameters" {
    iterator = task_invocation_parameters
    for_each = var.ssm_maintenance_window_task_task_invocation_parameters

    content {
      dynamic "automation_parameters" {
        iterator = automation_parameters
        for_each = lookup(task_invocation_parameters.value, "automation_parameters", [])

        content {
          document_version = lookup(automation_parameters.value, "document_version", null)

          dynamic "parameter" {
            iterator = parameter
            for_each = lookup(automation_parameters.value, "parameter", [])

            content {
              name   = lookup(parameter.value, "name", null)
              values = lookup(parameter.value, "values", null)
            }
          }
        }
      }

      dynamic "lambda_parameters" {
        iterator = lambda_parameters
        for_each = lookup(task_invocation_parameters.value, "lambda_parameters", [])

        content {
          client_context = lookup(lambda_parameters.value, "client_context", null)
          payload        = lookup(lambda_parameters.value, "payload", null)
          qualifier      = lookup(lambda_parameters.value, "qualifier", null)
        }
      }

      dynamic "run_command_parameters" {
        iterator = run_command_parameters
        for_each = lookup(task_invocation_parameters.value, "run_command_parameters", [])

        content {
          comment              = lookup(run_command_parameters.value, "comment", null)
          document_hash        = lookup(run_command_parameters.value, "document_hash", null)
          document_hash_type   = lookup(run_command_parameters.value, "document_hash_type", null)
          output_s3_bucket     = lookup(run_command_parameters.value, "output_s3_bucket", null)
          output_s3_key_prefix = lookup(run_command_parameters.value, "output_s3_key_prefix", null)
          service_role_arn     = lookup(run_command_parameters.value, "service_role_arn", null)
          timeout_seconds      = lookup(run_command_parameters.value, "timeout_seconds", null)

          dynamic "notification_config" {
            iterator = notification_config
            for_each = lookup(run_command_parameters.value, "notification_config", [])

            content {
              notification_arn    = lookup(notification_config.value, "notification_arn", null)
              notification_events = lookup(notification_config.value, "notification_events", null)
              notification_type   = lookup(notification_config.value, "notification_type", null)
            }
          }

          dynamic "parameter" {
            iterator = parameter
            for_each = lookup(run_command_parameters.value, "parameter", [])

            content {
              name   = lookup(parameter.value, "name", null)
              values = lookup(parameter.value, "values", null)
            }
          }
        }
      }

      dynamic "step_functions_parameters" {
        iterator = step_functions_parameters
        for_each = lookup(task_invocation_parameters.value, "step_functions_parameters", [])

        content {
          input = lookup(step_functions_parameters.value, "input", null)
          name  = lookup(step_functions_parameters.value, "name", null)
        }
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
