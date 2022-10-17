#---------------------------------------------------
# AWS Sagemaker flow definition
#---------------------------------------------------
resource "aws_sagemaker_flow_definition" "sagemaker_flow_definition" {
  count = var.enable_sagemaker_flow_definition ? 1 : 0

  flow_definition_name = var.sagemaker_flow_definition_flow_definition_name != "" ? var.sagemaker_flow_definition_flow_definition_name : "${lower(var.name)}-flow-definition-${lower(var.environment)}"
  role_arn             = var.sagemaker_flow_definition_role_arn

  dynamic "human_loop_config" {
    iterator = human_loop_config
    for_each = var.sagemaker_flow_definition_human_loop_config

    content {
      human_task_ui_arn                     = lookup(human_loop_config.value, "human_task_ui_arn", (var.enable_sagemaker_human_task_ui ? aws_sagemaker_human_task_ui.sagemaker_human_task_ui[count.index].arn : null))
      task_availability_lifetime_in_seconds = lookup(human_loop_config.value, "task_availability_lifetime_in_seconds", null)
      task_count                            = lookup(human_loop_config.value, "task_count", null)
      task_description                      = lookup(human_loop_config.value, "task_description", null)
      task_title                            = lookup(human_loop_config.value, "task_title", null)
      workteam_arn                          = lookup(human_loop_config.value, "workteam_arn", (var.enable_sagemaker_workteam ? aws_sagemaker_workteam.sagemaker_workteam[count.index].arn : null))

      task_keywords              = lookup(human_loop_config.value, "task_keywords", null)
      task_time_limit_in_seconds = lookup(human_loop_config.value, "task_time_limit_in_seconds", null)


      dynamic "public_workforce_task_price" {
        iterator = public_workforce_task_price
        for_each = length(keys(lookup(human_loop_config.value, "public_workforce_task_price", {}))) > 0 ? [lookup(human_loop_config.value, "public_workforce_task_price", {})] : []

        content {
          dynamic "amount_in_usd" {
            iterator = amount_in_usd
            for_each = length(keys(lookup(public_workforce_task_price.value, "amount_in_usd", {}))) > 0 ? [lookup(public_workforce_task_price.value, "amount_in_usd", {})] : []

            content {
              cents                     = lookup(amount_in_usd.value, "cents", null)
              tenth_fractions_of_a_cent = lookup(amount_in_usd.value, "tenth_fractions_of_a_cent", null)
              dollars                   = lookup(amount_in_usd.value, "dollars", null)
            }
          }
        }
      }
    }
  }

  dynamic "output_config" {
    iterator = output_config
    for_each = var.sagemaker_project_output_config

    content {
      s3_output_path = lookup(output_config.value, "s3_output_path", null)

      kms_key_id = lookup(output_config.value, "kms_key_id", null)
    }
  }

  dynamic "human_loop_activation_config" {
    iterator = human_loop_activation_config
    for_each = var.sagemaker_flow_definition_human_loop_activation_config

    content {
      dynamic "human_loop_activation_conditions_config" {
        iterator = human_loop_activation_conditions_config
        for_each = length(keys(lookup(human_loop_activation_config.value, "human_loop_activation_conditions_config", {}))) > 0 ? [lookup(human_loop_activation_config.value, "human_loop_activation_conditions_config", {})] : []

        content {
          human_loop_activation_conditions = lookup(human_loop_activation_conditions_config.value, "human_loop_activation_conditions", null)
        }
      }
    }
  }

  dynamic "human_loop_request_source" {
    iterator = human_loop_request_source
    for_each = var.sagemaker_flow_definition_human_loop_request_source

    content {
      aws_managed_human_loop_request_source = lookup(human_loop_request_source.value, "aws_managed_human_loop_request_source", null)
    }
  }

  tags = merge(
    {
      Name = var.sagemaker_flow_definition_flow_definition_name != "" ? var.sagemaker_flow_definition_flow_definition_name : "${lower(var.name)}-flow-definition-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_sagemaker_human_task_ui.sagemaker_human_task_ui,
    aws_sagemaker_workteam.sagemaker_workteam
  ]
}