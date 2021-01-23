#---------------------------------------------------
# Consul acl policy
#---------------------------------------------------
resource "consul_acl_policy" "acl_policy" {
  count = var.enable_acl_policy ? 1 : 0

  name  = var.acl_policy_name != "" ? var.acl_policy_name : "${var.name}-${var.environment}-acl-policy"
  rules = var.acl_policy_rules

  description = var.acl_policy_description
  datacenters = var.acl_policy_datacenters
  namespace   = var.acl_policy_namespace

  depends_on = []
}
