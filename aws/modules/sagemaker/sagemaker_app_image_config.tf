#---------------------------------------------------
# AWS sagemaker app image config
#---------------------------------------------------
resource "aws_sagemaker_app_image_config" "sagemaker_app_image_config" {
  count = var.enable_sagemaker_app_image_config ? 1 : 0

  app_image_config_name = var.sagemaker_app_image_config_name != "" ? lower(var.sagemaker_app_image_config_name) : "${lower(var.name)}-sagemaker-app-image-config-${lower(var.environment)}"

  kernel_gateway_image_config {

    dynamic "kernel_spec" {
      iterator = kernel_spec
      for_each = var.sagemaker_app_image_config_kernel_spec
      content {
        name = lookup(kernel_spec.value, "name", null)

        display_name = lookup(kernel_spec.value, "display_name", null)
      }
    }

    dynamic "file_system_config" {
      iterator = file_system_config
      for_each = var.sagemaker_app_image_config_file_system_config
      content {
        default_gid = lookup(file_system_config.value, "default_gid", null)
        default_uid = lookup(file_system_config.value, "default_uid", null)
        mount_path  = lookup(file_system_config.value, "mount_path", null)
      }
    }

  }

  // tags = merge(
  //   {
  //     Name = var.sagemaker_app_image_config_name != "" ? lower(var.sagemaker_app_image_config_name) : "${lower(var.name)}-sagemaker-app-image-config-${lower(var.environment)}"
  //   },
  //   var.tags
  // )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}