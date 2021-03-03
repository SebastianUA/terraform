#---------------------------------------------------
# AWS NLB
#---------------------------------------------------
resource "aws_lb" "nlb" {
  count = var.enable_nlb ? 1 : 0

  name        = lower(var.nlb_name) != null && var.nlb_name_prefix == null ? lower(var.nlb_name) : null
  name_prefix = var.nlb_name_prefix != null && lower(var.nlb_name) == null ? var.nlb_name_prefix : null
  subnets     = var.nlb_subnets
  internal    = var.nlb_internal

  enable_deletion_protection       = var.nlb_enable_deletion_protection
  enable_cross_zone_load_balancing = var.nlb_enable_cross_zone_load_balancing
  load_balancer_type               = var.nlb_load_balancer_type
  idle_timeout                     = var.nlb_idle_timeout
  ip_address_type                  = var.nlb_ip_address_type

  dynamic "access_logs" {
    iterator = access_logs
    for_each = var.nlb_access_logs

    content {
      enabled = lookup(access_logs.value, "enabled", null)
      bucket  = lookup(access_logs.value, "bucket", null)
      prefix  = lookup(access_logs.value, "prefix", null)
    }
  }

  dynamic "subnet_mapping" {
    iterator = subnet_mapping
    for_each = var.nlb_subnet_mapping

    content {
      subnet_id     = lookup(subnet_mapping.value, "subnet_id", null)
      allocation_id = lookup(subnet_mapping.value, "allocation_id", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.nlb_timeouts)) > 0 ? [var.nlb_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.nlb_name != "" && var.nlb_name_prefix == "" ? lower(var.nlb_name) : var.nlb_name_prefix
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []

}
