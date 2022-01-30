#---------------------------------------------------
# AWS DB proxy default target group
#---------------------------------------------------
resource "aws_db_proxy_default_target_group" "db_proxy_default_target_group" {
  count = var.enable_db_proxy_default_target_group ? 1 : 0

  db_proxy_name = var.db_proxy_default_target_group_db_proxy_name != "" ? var.db_proxy_default_target_group_db_proxy_name : (var.enable_db_proxy ? element(aws_db_proxy.db_proxy.*.name, 0) : null)

  dynamic "connection_pool_config" {
    iterator = connection_pool_config
    for_each = var.db_proxy_default_target_group_connection_pool_config

    content {
      connection_borrow_timeout    = lookup(connection_pool_config.value, "connection_borrow_timeout", null)
      init_query                   = lookup(connection_pool_config.value, "init_query", null)
      max_connections_percent      = lookup(connection_pool_config.value, "max_connections_percent", null)
      max_idle_connections_percent = lookup(connection_pool_config.value, "max_idle_connections_percent", null)
      session_pinning_filters      = lookup(connection_pool_config.value, "session_pinning_filters", null)
    }
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.db_proxy_default_target_group_timeouts)) > 0 ? [var.db_proxy_default_target_group_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_db_proxy.db_proxy
  ]
}