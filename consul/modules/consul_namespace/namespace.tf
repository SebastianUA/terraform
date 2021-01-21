#---------------------------------------------------
# Consul namespace
#---------------------------------------------------
resource "consul_namespace" "namespace" {
  count = var.enable_namespace ? 1 : 0

  name = var.namespace_name != "" ? var.namespace_name : "${var.name}-${var.environment}-ns"

  description     = var.namespace_description
  policy_defaults = var.namespace_policy_defaults
  role_defaults   = var.namespace_role_defaults
  meta            = var.namespace_meta

  depends_on = []
}
