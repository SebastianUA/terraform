#---------------------------------------------------
# Consul prepared query
#---------------------------------------------------
resource "consul_prepared_query" "prepared_query" {
  count = var.enable_prepared_query ? 1 : 0

  name    = var.prepared_query_name != "" ? var.prepared_query_name : "${var.name}-${var.environment}-prepared-query"
  service = var.prepared_query_service

  datacenter       = var.prepared_query_datacenter
  token            = var.prepared_query_token
  stored_token     = var.prepared_query_stored_token
  session          = var.prepared_query_session
  only_passing     = var.prepared_query_only_passing
  connect          = var.prepared_query_connect
  near             = var.prepared_query_near
  ignore_check_ids = var.prepared_query_ignore_check_ids
  node_meta        = var.prepared_query_node_meta

  dynamic "template" {
    iterator = template
    for_each = var.prepared_query_template

    content {
      type   = lookup(template.value, "type", null)
      regexp = lookup(template.value, "regexp", null)
    }
  }

  dynamic "failover" {
    iterator = failover
    for_each = var.prepared_query_failover

    content {
      nearest_n   = lookup(failover.value, "nearest_n", null)
      datacenters = lookup(failover.value, "datacenters", null)
    }
  }

  dynamic "dns" {
    iterator = dns
    for_each = var.prepared_query_dns

    content {
      ttl = lookup(dns.value, "ttl", null)
    }
  }

  tags = var.prepared_query_tags

  depends_on = []
}
