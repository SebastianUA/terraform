#---------------------------------------------------
# AWS Sagemaker space
#---------------------------------------------------
resource "aws_sagemaker_space" "sagemaker_space" {
  count = var.enable_sagemaker_space ? 1 : 0

  space_name = var.sagemaker_space_name != "" ? var.sagemaker_space_name : "${lower(var.name)}-space-${lower(var.environment)}"
  domain_id  = var.sagemaker_space_domain_id != "" ? var.sagemaker_space_domain_id : (var.enable_sagemaker_domain ? aws_sagemaker_domain.sagemaker_domain.0.id : null)

  dynamic "space_settings" {
    iterator = space_settings
    for_each = var.sagemaker_space_settings

    content {
      dynamic "jupyter_server_app_settings" {
        iterator = jupyter_server_app_settings
        for_each = length(keys(lookup(space_settings.value, "jupyter_server_app_settings", {}))) > 0 ? [lookup(space_settings.value, "jupyter_server_app_settings", {})] : []

        content {
          lifecycle_config_arns = lookup(jupyter_server_app_settings.value, "lifecycle_config_arns", null)

          dynamic "code_repository" {
            iterator = code_repository
            for_each = length(keys(lookup(jupyter_server_app_settings.value, "code_repository", {}))) > 0 ? [lookup(jupyter_server_app_settings.value, "code_repository", {})] : []

            content {
              repository_url = lookup(code_repository.value, "repository_url", null)
            }
          }

          dynamic "default_resource_spec" {
            iterator = default_resource_spec
            for_each = length(keys(lookup(jupyter_server_app_settings.value, "default_resource_spec", {}))) > 0 ? [lookup(jupyter_server_app_settings.value, "default_resource_spec", {})] : []

            content {
              instance_type               = lookup(default_resource_spec.value, "instance_type", null)
              lifecycle_config_arn        = lookup(default_resource_spec.value, "lifecycle_config_arn", null)
              sagemaker_image_arn         = lookup(default_resource_spec.value, "sagemaker_image_arn", null)
              sagemaker_image_version_arn = lookup(default_resource_spec.value, "sagemaker_image_version_arn", null)
            }
          }
        }
      }

      dynamic "kernel_gateway_app_settings" {
        iterator = kernel_gateway_app_settings
        for_each = length(keys(lookup(space_settings.value, "kernel_gateway_app_settings", {}))) > 0 ? [lookup(space_settings.value, "kernel_gateway_app_settings", {})] : []

        content {
          lifecycle_config_arns = lookup(kernel_gateway_app_settings.value, "lifecycle_config_arns", null)

          dynamic "default_resource_spec" {
            iterator = default_resource_spec
            for_each = length(keys(lookup(kernel_gateway_app_settings.value, "default_resource_spec", {}))) > 0 ? [lookup(kernel_gateway_app_settings.value, "default_resource_spec", {})] : []

            content {
              instance_type               = lookup(default_resource_spec.value, "instance_type", null)
              lifecycle_config_arn        = lookup(default_resource_spec.value, "lifecycle_config_arn", null)
              sagemaker_image_arn         = lookup(default_resource_spec.value, "sagemaker_image_arn", null)
              sagemaker_image_version_arn = lookup(default_resource_spec.value, "sagemaker_image_version_arn", null)
            }
          }

          dynamic "custom_image" {
            iterator = custom_image
            for_each = length(keys(lookup(kernel_gateway_app_settings.value, "custom_image", {}))) > 0 ? [lookup(kernel_gateway_app_settings.value, "custom_image", {})] : []

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
      Name = var.sagemaker_space_name != "" ? var.sagemaker_space_name : "${lower(var.name)}-space-${lower(var.environment)}"
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
