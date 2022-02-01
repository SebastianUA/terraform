#---------------------------------------------------
# Kubernetes namespace
#---------------------------------------------------
resource "kubernetes_namespace" "namespace" {
  count = var.enable_namespace ? 1 : 0

  metadata {
    name          = var.namespace_name != "" ? var.namespace_name : (var.namespace_generate_name == null ? "${lower(var.name)}-ns-${lower(var.environment)}" : null)
    generate_name = var.namespace_generate_name != null ? (var.namespace_name == "" ? var.namespace_generate_name : null) : null

    annotations = var.namespace_annotations
    labels      = var.namespace_labels
  }

  dynamic "timeouts" {
    iterator = timeouts
    for_each = length(keys(var.timeouts)) > 0 ? [var.timeouts] : []

    content {
      delete = lookup(timeouts.value, "delete", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
