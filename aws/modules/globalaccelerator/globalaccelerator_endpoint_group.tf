#---------------------------------------------------
# AWS globalaccelerator endpoint group
#---------------------------------------------------
resource "aws_globalaccelerator_endpoint_group" "globalaccelerator_endpoint_group" {
  count = var.enable_globalaccelerator_endpoint_group ? 1 : 0

  listener_arn = var.globalaccelerator_endpoint_group_listener_arn != "" && !var.enable_globalaccelerator_listener ? var.globalaccelerator_endpoint_group_listener_arn : element(concat(aws_globalaccelerator_listener.globalaccelerator_listener.*.id, [""]), 0)

  endpoint_group_region         = var.globalaccelerator_endpoint_group_endpoint_group_region
  health_check_interval_seconds = var.globalaccelerator_endpoint_group_health_check_interval_seconds
  health_check_path             = var.globalaccelerator_endpoint_group_health_check_path
  health_check_port             = var.globalaccelerator_endpoint_group_health_check_port
  health_check_protocol         = var.globalaccelerator_endpoint_group_health_check_protocol != null ? upper(var.globalaccelerator_endpoint_group_health_check_protocol) : null
  threshold_count               = var.globalaccelerator_endpoint_group_threshold_count
  traffic_dial_percentage       = var.globalaccelerator_endpoint_group_traffic_dial_percentage

  dynamic "endpoint_configuration" {
    iterator = endpoint_configuration
    for_each = var.globalaccelerator_endpoint_group_endpoint_configuration
    content {
      endpoint_id = lookup(endpoint_configuration.value, "endpoint_id", null)
      weight      = lookup(endpoint_configuration.value, "weight", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_globalaccelerator_listener.globalaccelerator_listener
  ]
}
