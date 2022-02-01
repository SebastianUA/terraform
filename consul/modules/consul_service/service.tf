#---------------------------------------------------
# Consul service
#---------------------------------------------------
resource "consul_service" "service" {
  count = var.enable_service ? 1 : 0

  name = var.service_name != "" ? var.service_name : "${var.name}-${var.environment}-service"
  node = var.service_node

  datacenter          = var.service_datacenter
  meta                = var.service_meta
  namespace           = var.service_namespace
  address             = var.service_address
  port                = var.service_port
  service_id          = var.service_service_id
  enable_tag_override = var.service_enable_tag_override

  dynamic "check" {
    iterator = check
    for_each = var.service_check

    content {
      name     = lookup(check.value, "name", null)
      interval = lookup(check.value, "interval", null)
      timeout  = lookup(check.value, "timeout", null)

      check_id                          = lookup(check.value, "check_id", null)
      notes                             = lookup(check.value, "notes", null)
      status                            = lookup(check.value, "status", null)
      tcp                               = lookup(check.value, "tcp", null)
      http                              = lookup(check.value, "http", null)
      tls_skip_verify                   = lookup(check.value, "tls_skip_verify", null)
      method                            = lookup(check.value, "method", null)
      deregister_critical_service_after = lookup(check.value, "deregister_critical_service_after", null)

      dynamic "header" {
        iterator = header
        for_each = lookup(check.value, "header", [])

        content {
          name  = lookup(header.value, "name", null)
          value = lookup(header.value, "value", null)
        }
      }
    }
  }

  tags = var.service_tags

  depends_on = []
}

