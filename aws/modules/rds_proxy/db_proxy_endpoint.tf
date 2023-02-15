#---------------------------------------------------
# AWS DB proxy endpoint
#---------------------------------------------------
resource "aws_db_proxy_endpoint" "db_proxy_endpoint" {
  count = var.enable_db_proxy_endpoint ? 1 : 0

  db_proxy_endpoint_name = var.db_proxy_endpoint_db_proxy_endpoint_name != "" ? lower(var.db_proxy_endpoint_db_proxy_endpoint_name) : "${var.name}-db-proxy-end-${var.environment}"
  db_proxy_name          = var.db_proxy_endpoint_db_proxy_name != "" ? var.db_proxy_endpoint_db_proxy_name : (var.enable_db_proxy ? element(aws_db_proxy.db_proxy.*.name, 0) : null)
  vpc_subnet_ids         = var.db_proxy_endpoint_vpc_subnet_ids

  vpc_security_group_ids = var.db_proxy_endpoint_vpc_security_group_ids
  target_role            = var.db_proxy_endpoint_target_role

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.db_proxy_endpoint_timeouts)) > 0 ? [var.db_proxy_endpoint_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.db_proxy_endpoint_db_proxy_endpoint_name != "" ? lower(var.db_proxy_endpoint_db_proxy_endpoint_name) : "${var.name}-db-proxy-end-${var.environment}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_db_proxy.db_proxy
  ]
}