#---------------------------------------------------
# AWS Sagemaker app
#---------------------------------------------------
resource "aws_sagemaker_app" "sagemaker_app" {
  count = var.enable_sagemaker_app ? 1 : 0

  app_name  = var.sagemaker_app_name != "" ? var.sagemaker_app_name : "${lower(var.name)}-app-${lower(var.environment)}"
  app_type  = var.sagemaker_app_type
  domain_id = var.sagemaker_app_domain_id != "" ? var.sagemaker_app_domain_id : (var.enable_sagemaker_domain ? aws_sagemaker_domain.sagemaker_domain[count.index].id : null)

  user_profile_name = var.sagemaker_app_user_profile_name != "" ? var.sagemaker_app_user_profile_name : (var.enable_sagemaker_user_profile ? aws_sagemaker_user_profile.sagemaker_user_profile[count.index].user_profile_name : null)
  space_name        = var.sagemaker_app_space_name

  dynamic "resource_spec" {
    iterator = resource_spec
    for_each = var.sagemaker_app_resource_spec

    content {
      instance_type               = lookup(resource_spec.value, "instance_type", null)
      lifecycle_config_arn        = lookup(resource_spec.value, "lifecycle_config_arn", null)
      sagemaker_image_arn         = lookup(resource_spec.value, "sagemaker_image_arn", null)
      sagemaker_image_version_arn = lookup(resource_spec.value, "sagemaker_image_version_arn", null)
    }
  }

  tags = merge(
    {
      Name = var.sagemaker_app_name != "" ? var.sagemaker_app_name : "${lower(var.name)}-app-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_sagemaker_domain.sagemaker_domain,
    aws_sagemaker_user_profile.sagemaker_user_profile
  ]
}