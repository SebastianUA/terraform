#---------------------------------------------------
# AWS sagemaker model package group
#---------------------------------------------------
resource "aws_sagemaker_model_package_group" "sagemaker_model_package_group" {
  count = var.enable_sagemaker_model_package_group ? 1 : 0

  model_package_group_name = var.sagemaker_model_package_group_name != "" ? lower(var.sagemaker_model_package_group_name) : "${lower(var.name)}-sagemaker-user-profile-${lower(var.environment)}"

  model_package_group_description = var.sagemaker_model_package_group_description

  tags = merge(
    {
      Name = var.sagemaker_model_package_group_name != "" ? lower(var.sagemaker_model_package_group_name) : "${lower(var.name)}-sagemaker-model-package-group-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}