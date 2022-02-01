#---------------------------------------------------
# Consul acl role
#---------------------------------------------------
resource "consul_acl_role" "acl_role" {
  count = var.enable_acl_role ? 1 : 0

  name = var.acl_role_name != "" ? var.acl_role_name : "${var.name}-${var.environment}-acl-policy"

  description = var.acl_role_description
  policies    = var.acl_role_policies != null ? var.acl_role_policies : (var.enable_acl_policy ? [consul_acl_policy.acl_policy[0].name] : null)
  namespace   = var.acl_role_namespace

  dynamic "service_identities" {
    iterator = service_identities
    for_each = var.acl_role_service_identities

    content {
      service_name = lookup(service_identities.value, "service_name", null)
      datacenters  = lookup(service_identities.value, "datacenters", null)
    }
  }

  depends_on = [
    consul_acl_policy.acl_policy
  ]
}
