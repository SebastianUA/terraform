#---------------------------------------------------
# AWS config configuration recorder
#---------------------------------------------------
resource "aws_config_configuration_recorder" "config_configuration_recorder" {
  count = var.enable_config_configuration_recorder ? 1 : 0

  name     = var.config_configuration_recorder_name != "" ? lower(var.config_configuration_recorder_name) : "${lower(var.name)}-config-recoder-${lower(var.environment)}"
  role_arn = var.config_configuration_recorder_role_arn

  dynamic "recording_group" {
    iterator = recording_group
    for_each = var.config_configuration_recorder_recording_group
    content {
      all_supported                 = lookup(recording_group.value, "all_supported", null)
      include_global_resource_types = lookup(recording_group.value, "include_global_resource_types", null)
      resource_types                = lookup(recording_group.value, "resource_types", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
