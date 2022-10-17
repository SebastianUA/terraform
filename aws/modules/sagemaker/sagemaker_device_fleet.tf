#---------------------------------------------------
# AWS Sagemaker device fleet
#---------------------------------------------------
resource "aws_sagemaker_device_fleet" "sagemaker_device_fleet" {
  count = var.enable_sagemaker_device_fleet ? 1 : 0

  device_fleet_name = var.sagemaker_device_fleet_name != "" ? var.sagemaker_device_fleet_name : "${lower(var.name)}-device-fleet-${lower(var.environment)}"
  role_arn          = var.sagemaker_device_fleet_role_arn

  description           = var.sagemaker_device_fleet_description
  enable_iot_role_alias = var.sagemaker_device_fleet_enable_iot_role_alias

  dynamic "output_config" {
    iterator = output_config
    for_each = var.sagemaker_device_fleet_output_config

    content {
      s3_output_location = lookup(output_config.value, "s3_output_location", null)

      kms_key_id = lookup(output_config.value, "kms_key_id", null)
    }
  }

  tags = merge(
    {
      Name = var.sagemaker_device_fleet_name != "" ? var.sagemaker_device_fleet_name : "${lower(var.name)}-device-fleet-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}