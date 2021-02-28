#---------------------------------------------------
# AWS Sagemaker domain
#---------------------------------------------------
resource "aws_sagemaker_domain" "sagemaker_domain" {
  count = var.enable_sagemaker_domain ? 1 : 0

  domain_name = var.sagemaker_domain_name != "" ? lower(var.sagemaker_domain_name) : "${lower(var.name)}-sagemaker-domain-${lower(var.environment)}"
  auth_mode   = var.sagemaker_domain_auth_mode
  vpc_id      = var.sagemaker_domain_vpc_id
  subnet_ids  = var.sagemaker_domain_subnet_ids

  kms_key_id              = var.sagemaker_domain_kms_key_id
  app_network_access_type = var.sagemaker_domain_app_network_access_type

  default_user_settings {
    execution_role = lookup(var.sagemaker_domain_default_user_settings, "execution_role", null)

    security_groups = lookup(var.sagemaker_domain_default_user_settings, "security_groups", null)

    dynamic "sharing_settings" {
      iterator = sharing_settings
      for_each = var.sagemaker_domain_sharing_settings
      content {
        notebook_output_option = lookup(sharing_settings.value, "notebook_output_option", null)
        s3_kms_key_id          = lookup(sharing_settings.value, "s3_kms_key_id", null)
        s3_output_path         = lookup(sharing_settings.value, "s3_output_path", null)
      }
    }

    dynamic "tensor_board_app_settings" {
      iterator = tensor_board_app_settings
      for_each = var.sagemaker_domain_tensor_board_app_settings
      content {
        default_resource_spec {
          instance_type       = lookup(tensor_board_app_settings.value, "instance_type", null)
          sagemaker_image_arn = lookup(tensor_board_app_settings.value, "sagemaker_image_arn", null)
        }
      }
    }

    dynamic "jupyter_server_app_settings" {
      iterator = jupyter_server_app_settings
      for_each = var.sagemaker_domain_jupyter_server_app_settings
      content {
        default_resource_spec {
          instance_type       = lookup(jupyter_server_app_settings.value, "instance_type", null)
          sagemaker_image_arn = lookup(jupyter_server_app_settings.value, "sagemaker_image_arn", null)
        }
      }
    }

    dynamic "kernel_gateway_app_settings" {
      iterator = kernel_gateway_app_settings
      for_each = var.sagemaker_domain_kernel_gateway_app_settings
      content {
        default_resource_spec {
          instance_type       = lookup(kernel_gateway_app_settings.value, "instance_type", null)
          sagemaker_image_arn = lookup(kernel_gateway_app_settings.value, "sagemaker_image_arn", null)
        }
        custom_image {
          app_image_config_name = lookup(kernel_gateway_app_settings.value, "app_image_config_name", null)
          image_name            = lookup(kernel_gateway_app_settings.value, "image_name", null)

          image_version_number = lookup(kernel_gateway_app_settings.value, "image_version_number", null)
        }
      }
    }

  }

  tags = merge(
    {
      Name = var.sagemaker_domain_name != "" ? lower(var.sagemaker_domain_name) : "${lower(var.name)}-sagemaker-domain-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
