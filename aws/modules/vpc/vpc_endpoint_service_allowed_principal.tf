#---------------------------------------------------
# AWS VPC endpoint service allowed principal
#---------------------------------------------------
resource "aws_vpc_endpoint_service_allowed_principal" "vpc_endpoint_service_allowed_principal" {
  count = var.enable_vpc_endpoint_service_allowed_principal ? 1 : 0

  vpc_endpoint_service_id = var.vpc_endpoint_service_allowed_principal_vpc_endpoint_service_id != "" ? var.vpc_endpoint_service_allowed_principal_vpc_endpoint_service_id : (var.enable_vpc_endpoint ? element(aws_vpc_endpoint_service.vpc_endpoint_service.*.id, 0) : null)
  principal_arn           = var.vpc_endpoint_service_allowed_principal_principal_arn

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc_endpoint_service.vpc_endpoint_service
  ]
}
