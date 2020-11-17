#---------------------------------------------------
# AWS NLB
#---------------------------------------------------
resource "aws_lb" "nlb" {
  count = var.enable_nlb ? 1 : 0

  name        = lower(var.nlb_name) != "" && var.name_prefix == "" ? lower(var.nlb_name) : null
  name_prefix = var.name_prefix != "" && lower(var.nlb_name) == "" ? var.name_prefix : null
  subnets     = var.subnets
  internal    = var.lb_internal

  enable_deletion_protection       = var.enable_deletion_protection
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  load_balancer_type               = var.load_balancer_type
  idle_timeout                     = var.idle_timeout
  ip_address_type                  = var.ip_address_type

  dynamic "access_logs" {
    for_each = var.access_logs
    content {
      enabled = lookup(access_logs.value, "enabled", null)
      bucket  = lookup(access_logs.value, "bucket", null)
      prefix  = lookup(access_logs.value, "prefix", null)
    }
  }

  dynamic "subnet_mapping" {
    for_each = var.subnet_mapping
    content {
      subnet_id     = lookup(subnet_mapping.value, "subnet_id", null)
      allocation_id = lookup(subnet_mapping.value, "allocation_id", null)
    }
  }

  timeouts {
    create = var.timeouts_create
    update = var.timeouts_update
    delete = var.timeouts_delete
  }

  tags = merge(
    {
      "Name" = var.nlb_name != "" && var.name_prefix == "" ? lower(var.nlb_name) : var.name_prefix
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []

}
