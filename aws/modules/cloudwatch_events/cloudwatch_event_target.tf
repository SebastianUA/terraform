#---------------------------------------------------
# Cloudwatch event target
#---------------------------------------------------
resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
  count = var.enable_cloudwatch_event_target ? 1 : 0

  rule = var.cloudwatch_event_target_rule != "" ? var.cloudwatch_event_target_rule : (var.enable_cloudwatch_event_rule ? aws_cloudwatch_event_rule.cloudwatch_event_rule.name : null)
  arn  = var.cloudwatch_event_target_arn

  event_bus_name    = var.cloudwatch_event_target_event_bus_name
  input             = var.cloudwatch_event_target_input
  input_path        = var.cloudwatch_event_target_input_path
  input_transformer = var.cloudwatch_event_target_input_transformer
  role_arn          = var.cloudwatch_event_target_role_arn
  target_id         = var.cloudwatch_event_target_target_id

  dynamic "batch_target" {
    iterator = batch_target
    for_each = length(keys(var.cloudwatch_event_target_batch_target)) > 0 ? [var.cloudwatch_event_target_batch_target] : []

    content {
      job_definition = lookup(batch_target.value, "job_definition", null)
      job_name       = lookup(batch_target.value, "job_name", null)

      array_size   = lookup(batch_target.value, "array_size", null)
      job_attempts = lookup(batch_target.value, "job_attempts", null)
    }
  }

  dynamic "dead_letter_config" {
    iterator = dead_letter_config
    for_each = length(keys(var.cloudwatch_event_target_dead_letter_config)) > 0 ? [var.cloudwatch_event_target_dead_letter_config] : []

    content {
      arn = lookup(dead_letter_config.value, "arn", null)
    }

  }

  dynamic "ecs_target" {
    iterator = ecs_target
    for_each = length(keys(var.cloudwatch_event_target_ecs_target)) > 0 ? [var.cloudwatch_event_target_ecs_target] : []

    content {
      task_definition_arn = lookup(ecs_target.value, "task_definition_arn", null)

      enable_ecs_managed_tags    = lookup(ecs_target.value, "enable_ecs_managed_tags", null)
      enable_execute_command     = lookup(ecs_target.value, "enable_execute_command", null)
      group                      = lookup(ecs_target.value, "group", null)
      launch_type                = lookup(ecs_target.value, "launch_type", null)
      network_configuration      = lookup(ecs_target.value, "network_configuration", null)
      ordered_placement_strategy = lookup(ecs_target.value, "ordered_placement_strategy", null)

      platform_version = lookup(ecs_target.value, "platform_version", null)
      propagate_tags   = lookup(ecs_target.value, "propagate_tags", null)
      task_count       = lookup(ecs_target.value, "task_count", null)
      tags             = lookup(ecs_target.value, "tags", null)

      dynamic "capacity_provider_strategy" {
        iterator = capacity_provider_strategy
        for_each = length(keys(lookup(ecs_target.value, "capacity_provider_strategy", {}))) > 0 ? [lookup(ecs_target.value, "capacity_provider_strategy", {})] : []

        content {
          capacity_provider = lookup(capacity_provider_strategy.value, "capacity_provider", null)
          weight            = lookup(capacity_provider_strategy.value, "weight", null)

          base = lookup(capacity_provider_strategy.value, "base", null)
        }
      }


      dynamic "placement_constraint" {
        iterator = placement_constraint
        for_each = length(keys(lookup(ecs_target.value, "placement_constraint", {}))) > 0 ? [lookup(ecs_target.value, "placement_constraint", {})] : []

        content {
          type = lookup(placement_constraint.value, "type", null)

          expression = lookup(placement_constraint.value, "expression", null)
        }
      }
    }
  }

  dynamic "http_target" {
    iterator = http_target
    for_each = length(keys(var.cloudwatch_event_target_http_target)) > 0 ? [var.cloudwatch_event_target_http_target] : []

    content {
      header_parameters       = lookup(http_target.value, "header_parameters", null)
      path_parameter_values   = lookup(http_target.value, "path_parameter_values", null)
      query_string_parameters = lookup(http_target.value, "query_string_parameters", null)
    }

  }

  dynamic "kinesis_target" {
    iterator = kinesis_target
    for_each = length(keys(var.cloudwatch_event_target_kinesis_target)) > 0 ? [var.cloudwatch_event_target_kinesis_target] : []

    content {
      partition_key_path = lookup(kinesis_target.value, "partition_key_path", null)
    }

  }

  dynamic "run_command_targets" {
    iterator = run_command_targets
    for_each = var.cloudwatch_event_target_run_command_targets

    content {
      key    = lookup(run_command_targets.value, "key", null)
      values = lookup(run_command_targets.value, "values", null)
    }

  }

  dynamic "redshift_target" {
    iterator = redshift_target
    for_each = length(keys(var.cloudwatch_event_target_redshift_target)) > 0 ? [var.cloudwatch_event_target_redshift_target] : []

    content {
      database = lookup(redshift_target.value, "database", null)

      db_user             = lookup(redshift_target.value, "db_user", null)
      secrets_manager_arn = lookup(redshift_target.value, "secrets_manager_arn", null)
      sql                 = lookup(redshift_target.value, "sql", null)
      statement_name      = lookup(redshift_target.value, "statement_name", null)
      with_event          = lookup(redshift_target.value, "with_event", null)
    }

  }

  dynamic "retry_policy" {
    iterator = retry_policy
    for_each = length(keys(var.cloudwatch_event_target_retry_policy)) > 0 ? [var.cloudwatch_event_target_retry_policy] : []

    content {
      maximum_event_age_in_seconds = lookup(retry_policy.value, "maximum_event_age_in_seconds", null)
      maximum_retry_attempts       = lookup(retry_policy.value, "maximum_retry_attempts", null)
    }

  }

  dynamic "sagemaker_pipeline_target" {
    iterator = sagemaker_pipeline_target
    for_each = length(keys(var.cloudwatch_event_target_sagemaker_pipeline_target)) > 0 ? [var.cloudwatch_event_target_sagemaker_pipeline_target] : []

    content {
      dynamic "pipeline_parameter_list" {
        iterator = pipeline_parameter_list
        for_each = length(keys(lookup(sagemaker_pipeline_target.value, "pipeline_parameter_list", {}))) > 0 ? [lookup(sagemaker_pipeline_target.value, "pipeline_parameter_list", {})] : []

        content {
          name  = lookup(pipeline_parameter_list.value, "name", null)
          value = lookup(pipeline_parameter_list.value, "value", null)
        }
      }
    }

  }

  dynamic "sqs_target" {
    iterator = sqs_target
    for_each = length(keys(var.cloudwatch_event_target_sqs_target)) > 0 ? [var.cloudwatch_event_target_sqs_target] : []

    content {
      message_group_id = lookup(sqs_target.value, "message_group_id", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_cloudwatch_event_rule.cloudwatch_event_rule
  ]
}