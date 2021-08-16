#---------------------------------------------------
# AWS Sagemaker endpoint
#---------------------------------------------------
resource "aws_sagemaker_endpoint" "sagemaker_endpoint" {
  count = var.enable_sagemaker_endpoint ? 1 : 0

  name                 = var.sagemaker_endpoint_name != "" ? lower(var.sagemaker_endpoint_name) : "${lower(var.name)}-endpoint-${lower(var.environment)}"
  endpoint_config_name = var.sagemaker_endpoint_endpoint_config_name != "" && !var.enable_sagemaker_endpoint_configuration ? var.sagemaker_endpoint_endpoint_config_name : element(concat(aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration.*.name, [""]), 0)

  tags = merge(
    {
      Name = var.sagemaker_endpoint_name != "" ? lower(var.sagemaker_endpoint_name) : "${lower(var.name)}-endpoint-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration
  ]
}
