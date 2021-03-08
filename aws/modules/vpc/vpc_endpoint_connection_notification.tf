#---------------------------------------------------
# AWS VPC endpoint connection notification
#---------------------------------------------------
resource "aws_vpc_endpoint_connection_notification" "vpc_endpoint_connection_notification" {
  count = var.enable_vpc_endpoint_connection_notification ? (var.enable_vpc_endpoint ? length(var.vpc_endpoint_stack) : (var.enable_vpc_endpoint_service ? length(var.vpc_endpoint_service_stack) : 0)) : 0

  connection_notification_arn = var.vpc_endpoint_connection_notification_connection_notification_arn
  connection_events           = var.vpc_endpoint_connection_notification_connection_events

  vpc_endpoint_service_id = var.vpc_endpoint_connection_notification_vpc_endpoint_service_id != "" ? var.vpc_endpoint_connection_notification_vpc_endpoint_service_id : (var.enable_vpc_endpoint_service ? element(aws_vpc_endpoint_service.vpc_endpoint_service.*.id, 0) : null)
  vpc_endpoint_id         = var.vpc_endpoint_connection_notification_vpc_endpoint_id != "" ? var.vpc_endpoint_connection_notification_vpc_endpoint_id : (var.enable_vpc_endpoint ? element(aws_vpc_endpoint.vpc_endpoint.*.id, 0) : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc_endpoint_service.vpc_endpoint_service,
    aws_vpc_endpoint.vpc_endpoint
  ]
}
