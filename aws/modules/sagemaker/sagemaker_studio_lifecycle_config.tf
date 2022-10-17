#---------------------------------------------------
# AWS Sagemaker studio lifecycle config
#---------------------------------------------------
resource "aws_sagemaker_studio_lifecycle_config" "sagemaker_studio_lifecycle_config" {
  count = var.enable_sagemaker_studio_lifecycle_config ? 1 : 0

  studio_lifecycle_config_name     = var.sagemaker_studio_lifecycle_config_name != "" ? var.sagemaker_studio_lifecycle_config_name : "${lower(var.name)}-studio-lifecycle-config-${lower(var.environment)}"
  studio_lifecycle_config_app_type = var.sagemaker_studio_lifecycle_config_app_type
  studio_lifecycle_config_content  = var.sagemaker_studio_lifecycle_config_content

  tags = merge(
    {
      Name = var.sagemaker_studio_lifecycle_config_name != "" ? var.sagemaker_studio_lifecycle_config_name : "${lower(var.name)}-studio-lifecycle-config-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}