#---------------------------------------------------
# AWS Sagemaker notebook instance
#---------------------------------------------------
resource "aws_sagemaker_notebook_instance" "sagemaker_notebook_instance" {
  count = var.enable_sagemaker_notebook_instance ? 1 : 0

  name          = var.sagemaker_notebook_instance_name != "" ? lower(var.sagemaker_notebook_instance_name) : "${lower(var.name)}-notebook-instance-${lower(var.environment)}"
  role_arn      = var.sagemaker_notebook_instance_role_arn
  instance_type = var.sagemaker_notebook_instance_instance_type

  subnet_id              = var.sagemaker_notebook_instance_subnet_id
  security_groups        = var.sagemaker_notebook_instance_security_groups
  kms_key_id             = var.sagemaker_notebook_instance_kms_key_id
  lifecycle_config_name  = var.sagemaker_notebook_instance_lifecycle_config_name != "" && !var.enable_sagemaker_notebook_instance_lifecycle_configuration ? var.sagemaker_notebook_instance_lifecycle_config_name : element(concat(aws_sagemaker_notebook_instance_lifecycle_configuration.sagemaker_notebook_instance_lifecycle_configuration.*.id, [""]), 0)
  direct_internet_access = var.sagemaker_notebook_instance_direct_internet_access

  tags = merge(
    {
      Name = var.sagemaker_notebook_instance_name != "" ? lower(var.sagemaker_notebook_instance_name) : "${lower(var.name)}-notebook-instance-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_sagemaker_notebook_instance_lifecycle_configuration.sagemaker_notebook_instance_lifecycle_configuration
  ]
}
