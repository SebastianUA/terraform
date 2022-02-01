#---------------------------------------------------
# Kubernetes role binding
#---------------------------------------------------
resource "kubernetes_role_binding" "role_binding" {
  count = var.enable_role_binding ? 1 : 0

  metadata {
    name = var.role_binding_name != "" ? var.role_binding_name : "${lower(var.name)}-cluster-role-${lower(var.environment)}"
    // name          = var.role_binding_name != "" ? var.role_binding_name : (var.role_binding_generate_name == null ? "${lower(var.name)}-cluster-role-${lower(var.environment)}" : null)
    // generate_name = var.role_binding_generate_name != null ? (var.role_binding_name == "" ? var.role_binding_generate_name : null) : null

    annotations = var.role_binding_annotations
    labels      = var.role_binding_labels
    namespace   = var.role_binding_namespace
  }

  dynamic "role_ref" {
    iterator = role_ref
    for_each = var.role_binding_role_refs

    content {
      api_group = lookup(role_ref.value, "api_group", null)
      kind      = lookup(role_ref.value, "kind", null)
      name      = lookup(role_ref.value, "name", null)
    }
  }

  dynamic "subject" {
    iterator = subject
    for_each = var.role_binding_subjects

    content {
      name      = lookup(subject.value, "name", null)
      kind      = lookup(subject.value, "kind", null)
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

