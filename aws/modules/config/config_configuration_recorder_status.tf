#---------------------------------------------------
# AWS config configuration recorder status
#---------------------------------------------------
resource "aws_config_configuration_recorder_status" "config_configuration_recorder_status" {
  count = var.enable_config_configuration_recorder_status ? 1 : 0

  name       = var.config_configuration_recorder_status_name != "" && !var.enable_config_configuration_recorder ? var.config_configuration_recorder_status_name : element(concat(aws_config_configuration_recorder.config_configuration_recorder.*.name, [""]), 0)
  is_enabled = var.config_configuration_recorder_status_is_enabled

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_config_configuration_recorder.config_configuration_recorder
  ]
}
