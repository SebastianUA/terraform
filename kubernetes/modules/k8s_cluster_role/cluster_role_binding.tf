#---------------------------------------------------
# Kubernetes cluster role binding
#---------------------------------------------------
resource "kubernetes_cluster_role_binding" "cluster_role_binding" {
  count = var.enable_cluster_role_binding ? 1 : 0

  metadata {
    name = var.cluster_role_binding_name != "" ? var.cluster_role_binding_name : "${lower(var.name)}-cluster-role-binding-${lower(var.environment)}"
    // name          = var.cluster_role_binding_name != "" ? var.cluster_role_binding_name : (var.cluster_role_binding_generate_name == null ? "${lower(var.name)}-cluster-role-${lower(var.environment)}" : null)
    // generate_name = var.cluster_role_binding_generate_name != null ? (var.cluster_role_binding_name == "" ? var.cluster_role_binding_generate_name : null) : null

    annotations = var.cluster_role_binding_annotations
    labels      = var.cluster_role_binding_labels
  }

  dynamic "role_ref" {
    iterator = role_ref
    for_each = var.cluster_role_binding_role_ref
    content {
      api_group = lookup(role_ref.value, "api_group", "rbac.authorization.k8s.io")
      kind      = lookup(role_ref.value, "kind", "ClusterRole")
      name      = lookup(role_ref.value, "name", "")
    }
  }

  dynamic "subject" {
    iterator = subject
    for_each = var.cluster_role_binding_subject
    content {
      name      = lookup(subject.value, "name", "")
      kind      = lookup(subject.value, "kind", "")
      namespace = lookup(subject.value, "namespace", null)
      api_group = lookup(subject.value, "api_group", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

