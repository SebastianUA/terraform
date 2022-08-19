#---------------------------------------------------
# AWS route53 resolver endpoint
#---------------------------------------------------
resource "aws_route53_resolver_endpoint" "route53_resolver_endpoint" {
  count = var.enable_route53_resolver_endpoint ? 1 : 0

  name               = var.route53_resolver_endpoint_name != "" ? lower(var.route53_resolver_endpoint_name) : "${lower(var.name)}-route53_resolve-endpoint-${lower(var.environment)}"
  direction          = var.route53_resolver_endpoint_direction
  security_group_ids = var.route53_resolver_endpoint_security_group_ids

  dynamic "ip_address" {
    iterator = ip_address
    for_each = var.route53_resolver_endpoint_ip_address

    content {
      subnet_id = lookup(ip_address.value, "subnet_id", null)
      ip        = lookup(ip_address.value, "ip", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.route53_resolver_endpoint_timeouts)) > 0 ? [var.route53_resolver_endpoint_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.route53_resolver_endpoint_name != "" ? lower(var.route53_resolver_endpoint_name) : "${lower(var.name)}-route53_resolve-endpoint-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
