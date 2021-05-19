#---------------------------------------------------
# AWS WAF ipset
#---------------------------------------------------
resource "aws_waf_ipset" "waf_ipset" {
  count = var.enable_waf_ipset ? 1 : 0

  name = var.waf_ipset_name != "" ? lower(var.waf_ipset_name) : "${lower(var.name)}-waf-ipset-${lower(var.environment)}"

  dynamic "ip_set_descriptors" {
    iterator = ip_set_descriptors
    for_each = length(var.waf_ipset_ip_set_descriptors) > 0 ? [var.waf_ipset_ip_set_descriptors] : []

    content {
      type  = lookup(ip_set_descriptors.value, "type", null)
      value = lookup(ip_set_descriptors.value, "value", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
