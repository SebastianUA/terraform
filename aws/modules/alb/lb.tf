#---------------------------------------------------
# AWS ALB
#---------------------------------------------------
resource "aws_lb" "alb" {
  count = var.enable_alb ? 1 : 0

  name        = var.alb_name != "" ? var.alb_name : (var.alb_name_prefix == null ? "${lower(var.name)}-alb-${lower(var.environment)}" : null)
  name_prefix = var.alb_name_prefix != null ? (var.alb_name == "" ? var.alb_name_prefix : null) : null

  security_groups = var.alb_security_groups
  subnets         = var.alb_subnets
  internal        = var.alb_internal

  enable_cross_zone_load_balancing = var.alb_enable_cross_zone_load_balancing
  enable_deletion_protection       = var.alb_enable_deletion_protection
  load_balancer_type               = var.alb_load_balancer_type
  idle_timeout                     = var.alb_idle_timeout
  enable_http2                     = var.alb_enable_http2
  ip_address_type                  = var.alb_ip_address_type
  drop_invalid_header_fields       = var.alb_drop_invalid_header_fields
  customer_owned_ipv4_pool         = var.alb_customer_owned_ipv4_pool

  dynamic "access_logs" {
    iterator = access_logs
    for_each = var.alb_access_logs

    content {
      enabled = lookup(access_logs.value, "enabled", null)
      bucket  = lookup(access_logs.value, "bucket", null)
      prefix  = lookup(access_logs.value, "prefix", null)
    }
  }

  # not working with subnets
  dynamic "subnet_mapping" {
    iterator = subnet_mapping
    for_each = var.alb_subnet_mapping

    content {
      subnet_id            = lookup(subnet_mapping.value, "subnet_id", null)
      allocation_id        = lookup(subnet_mapping.value, "allocation_id", null)
      private_ipv4_address = lookup(subnet_mapping.value, "private_ipv4_address", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.alb_timeouts)) > 0 ? [var.alb_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.alb_name != "" ? var.alb_name : (var.alb_name_prefix == null ? "${lower(var.name)}-alb-${lower(var.environment)}" : var.alb_name_prefix)
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
