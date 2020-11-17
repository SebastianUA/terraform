#---------------------------------------------------
# AWS sagemaker notebook instance lifecycle configuration
#---------------------------------------------------
resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "sagemaker_notebook_instance_lifecycle_configuration" {
  count = var.enable_sagemaker_notebook_instance_lifecycle_configuration ? 1 : 0

  name      = var.sagemaker_notebook_instance_lifecycle_configuration_name != "" ? lower(var.sagemaker_notebook_instance_lifecycle_configuration_name) : "${lower(var.name)}-sagemaker-notebook-inst-lc-conf-${lower(var.environment)}"
  on_create = var.sagemaker_notebook_instance_lifecycle_configuration_on_create
  on_start  = var.sagemaker_notebook_instance_lifecycle_configuration_on_start

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
