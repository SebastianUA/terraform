#---------------------------------------------------
# Kubernetes role
#---------------------------------------------------
resource "kubernetes_role" "role" {
  count = var.enable_role ? 1 : 0

  metadata {
    name          = var.role_name != "" ? var.role_name : "${lower(var.name)}-role-${lower(var.environment)}"
    generate_name = var.role_generate_name

    annotations = var.role_annotations
    labels      = var.role_labels
    namespace   = var.role_namespace
  }

  dynamic "rule" {
    iterator = rule
    for_each = var.role_rules

    content {
      api_groups = lookup(rule.value, "api_groups", [])
      resources  = lookup(rule.value, "resources", [])
      verbs      = lookup(rule.value, "verbs", [])

      resource_names = lookup(rule.value, "resource_names", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

