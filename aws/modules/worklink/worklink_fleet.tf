#---------------------------------------------------
# AWS worklink fleet
#---------------------------------------------------
resource "aws_worklink_fleet" "worklink_fleet" {
  count = var.enable_worklink_fleet ? 1 : 0

  name = var.worklink_fleet_name != "" ? lower(var.worklink_fleet_name) : "${lower(var.name)}-worklink-fleet-${lower(var.environment)}"

  audit_stream_arn               = var.worklink_fleet_audit_stream_arn
  device_ca_certificate          = var.worklink_fleet_device_ca_certificate
  display_name                   = var.worklink_fleet_display_name
  optimize_for_end_user_location = var.worklink_fleet_optimize_for_end_user_location

  dynamic "network" {
    iterator = network
    for_each = var.worklink_fleet_network
    content {
      vpc_id             = lookup(network.value, "vpc_id", null)
      subnet_ids         = lookup(network.value, "subnet_ids", null)
      security_group_ids = lookup(network.value, "security_group_ids", null)
    }
  }

  dynamic "identity_provider" {
    iterator = identity_provider
    for_each = var.worklink_fleet_identity_provider
    content {
      type          = lookup(identity_provider.value, "type", null)
      saml_metadata = lookup(identity_provider.value, "saml_metadata", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
