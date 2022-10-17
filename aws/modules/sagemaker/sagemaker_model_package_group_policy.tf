#---------------------------------------------------
# AWS Sagemaker model package group policy
#---------------------------------------------------
resource "aws_sagemaker_model_package_group_policy" "sagemaker_model_package_group_policy" {
  count = var.enable_sagemaker_model_package_group_policy ? 1 : 0

  model_package_group_name = var.sagemaker_model_package_group_policy_model_package_group_name != "" ? var.sagemaker_model_package_group_policy_model_package_group_name : (var.enable_sagemaker_model_package_group ? aws_sagemaker_model_package_group.sagemaker_model_package_group[count.index].model_package_group_name : null)
  resource_policy          = var.sagemaker_model_package_group_policy_resource_policy

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_sagemaker_device_fleet.sagemaker_device_fleet
  ]
}