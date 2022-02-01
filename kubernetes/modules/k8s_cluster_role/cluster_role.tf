#---------------------------------------------------
# Kubernetes cluster role
#---------------------------------------------------
resource "kubernetes_cluster_role" "cluster_role" {
  count = var.enable_cluster_role ? 1 : 0

  metadata {
    name = var.cluster_role_name != "" ? var.cluster_role_name : "${lower(var.name)}-cluster-role-${lower(var.environment)}"
    // name          = var.cluster_role_name != "" ? var.cluster_role_name : (var.cluster_role_generate_name == null ? "${lower(var.name)}-cluster-role-${lower(var.environment)}" : null)
    // generate_name = var.cluster_role_generate_name != null ? (var.cluster_role_name == "" ? var.cluster_role_generate_name : null) : null

    annotations = var.cluster_role_annotations
    labels      = var.cluster_role_labels
  }

  dynamic "rule" {
    iterator = rule
    for_each = var.cluster_role_rules

    content {
      verbs      = lookup(rule.value, "verbs", [])
      api_groups = lookup(rule.value, "api_groups", null)
      resources  = lookup(rule.value, "resources", null)

      non_resource_urls = lookup(rule.value, "non_resource_urls", null)
      resource_names    = lookup(rule.value, "resource_names", null)
    }
  }

  dynamic "aggregation_rule" {
    iterator = aggregation_rule
    for_each = var.cluster_role_aggregation_rules

    content {
      dynamic "cluster_role_selectors" {
        iterator = cluster_role_selectors
        for_each = lookup(aggregation_rule.value, "cluster_role_selectors", [])

        content {
          match_labels = lookup(cluster_role_selectors.value, "match_labels", null)

          dynamic "match_expressions" {
            iterator = match_expressions
            for_each = lookup(cluster_role_selectors.value, "match_expressions", [])

            content {
              key      = lookup(match_expressions.value, "key", null)
              operator = lookup(match_expressions.value, "operator", null)
              values   = lookup(match_expressions.value, "values", null)
            }
          }
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

