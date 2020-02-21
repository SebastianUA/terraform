#-----------------------------------------------------------
# AWS SSM window task
#-----------------------------------------------------------
resource "aws_ssm_maintenance_window_task" "ssm_maintenance_window_task" {
    count                       = var.enable_ssm_maintenance_window_task ? 1 : 0

    name                        = var.ssm_maintenance_window_task_name != "" ? lower(var.ssm_maintenance_window_task_name) : "${lower(var.name)}-mw-task-${lower(var.environment)}"
    description                 = var.ssm_maintenance_window_task_description
    max_concurrency             = var.ssm_maintenance_window_task_max_concurrency
    max_errors                  = var.ssm_maintenance_window_task_max_errors
    priority                    = var.ssm_maintenance_window_task_priority
    service_role_arn            = var.ssm_maintenance_window_task_service_role_arn
    task_arn                    = var.ssm_maintenance_window_task_task_arn
    task_type                   = upper(var.ssm_maintenance_window_task_task_type)
    window_id                   = var.ssm_maintenance_window_task_window_id !="" ? var.ssm_maintenance_window_task_window_id  : element(concat(aws_ssm_maintenance_window.ssm_maintenance_window.*.id, [""]), 0)

    targets {
        key    = var.ssm_maintenance_window_task_targets_key
        values = var.ssm_maintenance_window_task_targets_values
    }

    task_invocation_parameters {
        automation_parameters {
            document_version    = var.enable_automation_parameters && var.automation_parameters_document_version != "" ? var.automation_parameters_document_version : null
            parameter {
                name    = var.enable_automation_parameters && var.automation_parameters_parameter_name != "" ? var.automation_parameters_parameter_name : "InstanceId"
                values  = var.enable_automation_parameters && length(var.automation_parameters_parameter_values) >0 ? var.automation_parameters_parameter_values : []
            }
        }

        lambda_parameters {
            client_context      = var.enable_lambda_parameters && var.lambda_parameters_client_context != null ? var.lambda_parameters_client_context : null
            payload             = var.enable_lambda_parameters && var.lambda_parameters_payload != null ? var.lambda_parameters_payload : null
            qualifier           = var.enable_lambda_parameters && var.lambda_parameters_qualifier != null ? var.lambda_parameters_qualifier : null
        }
        
        run_command_parameters {
            comment                 = var.enable_run_command_parameters && var.run_command_parameters_comment != null ? var.run_command_parameters_comment : null
            document_hash           = var.enable_run_command_parameters && var.run_command_parameters_document_hash != null ? upper(var.run_command_parameters_document_hash) : null
            document_hash_type      = var.enable_run_command_parameters && var.run_command_parameters_document_hash_type != null ? var.run_command_parameters_document_hash_type : null
            output_s3_bucket        = var.enable_run_command_parameters && var.run_command_parameters_output_s3_bucket != null ? var.run_command_parameters_output_s3_bucket : null
            output_s3_key_prefix    = var.enable_run_command_parameters && var.run_command_parameters_output_s3_key_prefix != null ? var.run_command_parameters_output_s3_key_prefix : null
            service_role_arn        = var.enable_run_command_parameters && var.run_command_parameters_service_role_arn != null ? var.run_command_parameters_service_role_arn : null
            timeout_seconds         = var.enable_run_command_parameters && var.run_command_parameters_timeout_seconds != null ? var.run_command_parameters_timeout_seconds : null

            notification_config {
                notification_arn    = var.enable_notification_config && var.notification_config_notification_arn != null ? var.notification_config_notification_arn : null
                notification_events = var.enable_notification_config && var.notification_config_notification_events != null ? var.notification_config_notification_events : null
                notification_type   = var.enable_notification_config && var.notification_config_notification_type != null ? var.notification_config_notification_type : null
            }

            parameter {
                name    = var.enable_run_command_parameters_parameter && var.run_command_parameters_parameter_name != "" ? var.run_command_parameters_parameter_name : "InstanceId"
                values  = var.enable_run_command_parameters_parameter && length(var.command_parameters_parameter_values) >0 ? var.command_parameters_parameter_values : []
            }
        }

        step_functions_parameters {
            input       = var.enable_step_functions_parameters && var.step_functions_parameters_input != null ? var.step_functions_parameters_input : null
            name        = var.enable_step_functions_parameters && var.step_functions_parameters_name != null ? var.step_functions_parameters_name : null
        }
    }

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on                  = [
        aws_ssm_maintenance_window.ssm_maintenance_window
    ]
}