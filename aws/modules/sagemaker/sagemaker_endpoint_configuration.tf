#---------------------------------------------------
# AWS Sagemaker endpoint configuration
#---------------------------------------------------
resource "aws_sagemaker_endpoint_configuration" "sagemaker_endpoint_configuration" {
  count = var.enable_sagemaker_endpoint_configuration ? 1 : 0

  name = var.sagemaker_endpoint_configuration_name != "" ? lower(var.sagemaker_endpoint_configuration_name) : "${lower(var.name)}-endpoint-conf-${lower(var.environment)}"

  kms_key_arn = var.sagemaker_endpoint_configuration_kms_key_arn

  dynamic "production_variants" {
    iterator = production_variants
    for_each = var.sagemaker_endpoint_configuration_production_variants

    content {
      model_name             = lookup(production_variants.value, "model_name", element(concat(aws_sagemaker_model.sagemaker_model.*.name, [""]), 0))
      initial_instance_count = lookup(production_variants.value, "initial_instance_count", 0)
      instance_type          = lookup(production_variants.value, "instance_type", "ml.t2.medium")

      variant_name           = lookup(production_variants.value, "variant_name", null)
      accelerator_type       = lookup(production_variants.value, "accelerator_type", null)
      initial_variant_weight = lookup(production_variants.value, "initial_variant_weight", null)
    }
  }

  tags = merge(
    {
      Name = var.sagemaker_endpoint_configuration_name != "" ? lower(var.sagemaker_endpoint_configuration_name) : "${lower(var.name)}-sagemaker-endpoint-conf-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_sagemaker_model.sagemaker_model
  ]
}
