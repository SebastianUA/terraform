#---------------------------------------------------
# AWS Sagemaker device
#---------------------------------------------------
resource "aws_sagemaker_device" "sagemaker_device" {
  count = var.enable_sagemaker_device ? 1 : 0

  device_fleet_name = var.sagemaker_device_device_fleet_name != "" ? var.sagemaker_device_device_fleet_name : (var.enable_sagemaker_device_fleet ? aws_sagemaker_device_fleet.sagemaker_device_fleet[count.index].device_fleet_name : null)

  dynamic "device" {
    iterator = device
    for_each = var.sagemaker_device_devices

    content {
      description = lookup(device.value, "description", null)

      device_name    = lookup(device.value, "device_name", null)
      iot_thing_name = lookup(device.value, "iot_thing_name", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_sagemaker_device_fleet.sagemaker_device_fleet
  ]
}
