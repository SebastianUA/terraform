#---------------------------------------------------
# AWS Sagemaker user profile 
#---------------------------------------------------
resource "aws_sagemaker_user_profile" "sagemaker_user_profile" {
  count = var.enable_sagemaker_user_profile ? 1 : 0

  user_profile_name         = var.sagemaker_user_profile_name != "" ? lower(var.sagemaker_user_profile_name) : "${lower(var.name)}-user-profile-${lower(var.environment)}"
  domain_id                 = var.sagemaker_user_profile_domain_id != "" ? var.sagemaker_user_profile_domain_id : (var.enable_sagemaker_domain ? aws_sagemaker_domain.sagemaker_domain.0.id : null)
  single_sign_on_user_value = var.sagemaker_user_profile_single_sign_on_user_value

  single_sign_on_user_identifier = var.sagemaker_user_profile_single_sign_on_user_identifier

  dynamic "default_user_settings" {
    iterator = default_user_settings
    for_each = length(keys(var.sagemaker_user_profile_user_settings)) > 0 ? [var.sagemaker_domain_default_user_settings] : []

    content {
      execution_role = lookup(default_user_settings.value, "execution_role", null)

      security_groups = lookup(default_user_settings.value, "execution_role", null)

      dynamic "r_session_app_settings" {
        iterator = r_session_app_settings
        for_each = lookup(default_user_settings.value, "r_session_app_settings", [])

        content {
          dynamic "default_resource_spec" {
            iterator = default_resource_spec
            for_each = lookup(r_session_app_settings.value, "default_resource_spec", [])

            content {
              instance_type               = lookup(default_resource_spec.value, "instance_type", null)
              lifecycle_config_arn        = lookup(default_resource_spec.value, "lifecycle_config_arn", null)
              sagemaker_image_arn         = lookup(default_resource_spec.value, "sagemaker_image_arn", null)
              sagemaker_image_version_arn = lookup(default_resource_spec.value, "sagemaker_image_version_arn", null)
            }
          }

          dynamic "custom_image" {
            iterator = custom_image
            for_each = lookup(r_session_app_settings.value, "custom_image", [])

            content {
              app_image_config_name = lookup(custom_image.value, "app_image_config_name", null)
              image_name            = lookup(custom_image.value, "image_name", null)

              image_version_number = lookup(custom_image.value, "image_version_number", null)
            }
          }
        }
      }

      dynamic "r_studio_server_pro_app_settings" {
        iterator = r_studio_server_pro_app_settings
        for_each = lookup(default_user_settings.value, "r_studio_server_pro_app_settings", [])

        content {
          access_status = lookup(r_studio_server_pro_app_settings.value, "access_status", null)
          user_group    = lookup(r_studio_server_pro_app_settings.value, "user_group", null)
        }
      }

      dynamic "canvas_app_settings" {
        iterator = canvas_app_settings
        for_each = lookup(default_user_settings.value, "canvas_app_settings", [])

        content {
          dynamic "model_register_settings" {
            iterator = model_register_settings
            for_each = lookup(canvas_app_settings.value, "model_register_settings", [])

            content {
              cross_account_model_register_role_arn = lookup(model_register_settings.value, "cross_account_model_register_role_arn", null)
              status                                = lookup(model_register_settings.value, "status", null)
            }
          }

          dynamic "time_series_forecasting_settings" {
            iterator = time_series_forecasting_settings
            for_each = lookup(canvas_app_settings.value, "time_series_forecasting_settings", [])

            content {
              amazon_forecast_role_arn = lookup(time_series_forecasting_settings.value, "amazon_forecast_role_arn", null)
              status                   = lookup(time_series_forecasting_settings.value, "status", null)
            }
          }

          dynamic "workspace_settings" {
            iterator = workspace_settings
            for_each = lookup(canvas_app_settings.value, "workspace_settings", [])

            content {
              s3_artifact_path = lookup(workspace_settings.value, "s3_artifact_path", null)
              s3_kms_key_id    = lookup(workspace_settings.value, "s3_kms_key_id", null)
            }
          }
        }
      }

      dynamic "sharing_settings" {
        iterator = sharing_settings
        for_each = lookup(default_user_settings.value, "sharing_settings", [])

        content {
          notebook_output_option = lookup(sharing_settings.value, "notebook_output_option", null)
          s3_kms_key_id          = lookup(sharing_settings.value, "s3_kms_key_id", null)
          s3_output_path         = lookup(sharing_settings.value, "s3_output_path", null)
        }
      }

      dynamic "tensor_board_app_settings" {
        iterator = tensor_board_app_settings
        for_each = lookup(default_user_settings.value, "tensor_board_app_settings", [])

        content {
          dynamic "default_resource_spec" {
            iterator = default_resource_spec
            for_each = lookup(tensor_board_app_settings.value, "default_resource_spec", [])

            content {
              instance_type       = lookup(default_resource_spec.value, "instance_type", null)
              sagemaker_image_arn = lookup(default_resource_spec.value, "sagemaker_image_arn", null)
            }
          }
        }
      }

      dynamic "jupyter_server_app_settings" {
        iterator = jupyter_server_app_settings
        for_each = lookup(default_user_settings.value, "jupyter_server_app_settings", [])

        content {
          dynamic "default_resource_spec" {
            iterator = default_resource_spec
            for_each = lookup(jupyter_server_app_settings.value, "default_resource_spec", [])

            content {
              instance_type       = lookup(default_resource_spec.value, "instance_type", null)
              sagemaker_image_arn = lookup(default_resource_spec.value, "sagemaker_image_arn", null)
            }
          }
        }
      }

      dynamic "kernel_gateway_app_settings" {
        iterator = kernel_gateway_app_settings
        for_each = lookup(default_user_settings.value, "kernel_gateway_app_settings", [])

        content {
          dynamic "default_resource_spec" {
            iterator = default_resource_spec
            for_each = lookup(kernel_gateway_app_settings.value, "default_resource_spec", [])

            content {
              instance_type       = lookup(default_resource_spec.value, "instance_type", null)
              sagemaker_image_arn = lookup(default_resource_spec.value, "sagemaker_image_arn", null)
            }
          }

          dynamic "custom_image" {
            iterator = custom_image
            for_each = lookup(kernel_gateway_app_settings.value, "custom_image", [])

            content {
              app_image_config_name = lookup(custom_image.value, "app_image_config_name", null)
              image_name            = lookup(custom_image.value, "image_name", null)

              image_version_number = lookup(custom_image.value, "image_version_number", null)
            }
          }
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.sagemaker_user_profile_name != "" ? lower(var.sagemaker_user_profile_name) : "${lower(var.name)}-user-profile-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_sagemaker_domain.sagemaker_domain
  ]
}
