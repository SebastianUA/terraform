#---------------------------------------------------
# AWS DB proxy
#---------------------------------------------------
resource "aws_db_proxy" "db_proxy" {
  count = var.enable_db_proxy ? 1 : 0

  name           = var.db_proxy_name != "" ? lower(var.db_proxy_name) : "${var.name}-db-proxy-${var.environment}"
  engine_family  = upper(var.db_proxy_engine_family)
  role_arn       = var.db_proxy_role_arn
  vpc_subnet_ids = var.db_proxy_vpc_subnet_ids

  dynamic "auth" {
    iterator = auth
    for_each = var.db_proxy_auth

    content {
      description = lookup(auth.value, "description", null)
      username    = lookup(auth.value, "username", null)
      auth_scheme = lookup(auth.value, "auth_scheme", null)
      iam_auth    = lookup(auth.value, "iam_auth", null)
      secret_arn  = lookup(auth.value, "secret_arn", null)
    }
  }

  debug_logging          = var.db_proxy_debug_logging
  idle_client_timeout    = var.db_proxy_idle_client_timeout
  require_tls            = var.db_proxy_require_tls
  vpc_security_group_ids = var.db_proxy_vpc_security_group_ids

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.db_proxy_timeouts)) > 0 ? [var.db_proxy_timeouts] : []

    content {
      create = lookup(timeouts.value, "create", null)
      update = lookup(timeouts.value, "update", null)
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  tags = merge(
    {
      Name = var.db_proxy_name != "" && var.db_proxy_name == "" ? lower(var.db_proxy_name) : "${var.name}-db-proxy-${var.environment}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}