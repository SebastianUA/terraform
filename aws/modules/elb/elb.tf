#---------------------------------------------------
# Create AWS ELB
#---------------------------------------------------
resource "aws_elb" "elb" {
  count = var.enable_elb ? 1 : 0

  name               = var.elb_name != "" ? var.elb_name : "${lower(var.name)}-elb-${lower(var.environment)}"
  availability_zones = var.availability_zones
  subnets            = var.subnets
  security_groups    = var.security_groups
  internal           = var.elb_internal

  cross_zone_load_balancing   = var.cross_zone_load_balancing
  idle_timeout                = var.idle_timeout
  connection_draining         = var.connection_draining
  connection_draining_timeout = var.connection_draining_timeout

  dynamic "access_logs" {
    for_each = var.access_logs
    content {
      bucket        = lookup(access_logs.value, "bucket", null)
      bucket_prefix = lookup(access_logs.value, "bucket_prefix", null)
      interval      = lookup(access_logs.value, "interval", null)
      enabled       = lookup(access_logs.value, "enabled", null)
    }
  }

  dynamic "listener" {
    for_each = var.listener
    content {
      instance_port      = lookup(listener.value, "instance_port", null)
      instance_protocol  = lookup(listener.value, "instance_protocol", null)
      lb_port            = lookup(listener.value, "lb_port", null)
      lb_protocol        = lookup(listener.value, "lb_protocol", null)
      ssl_certificate_id = lookup(listener.value, "ssl_certificate_id", null)
    }
  }

  dynamic "health_check" {
    for_each = var.health_check
    content {
      healthy_threshold   = lookup(health_check.value, "healthy_threshold", null)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)
      target              = lookup(health_check.value, "target", null)
      interval            = lookup(health_check.value, "interval", null)
      timeout             = lookup(health_check.value, "timeout", null)
    }
  }

  tags = merge(
    {
      Name = var.elb_name != "" ? var.elb_name : "${lower(var.name)}-elb-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
