#---------------------------------------------------
# Kubernetes secret
#---------------------------------------------------
resource "kubernetes_secret" "secret" {
  count = var.enable_secret ? 1 : 0

  metadata {
    name          = var.secret_name != "" ? var.secret_name : (var.secret_generate_name == null ? "${lower(var.name)}-secret-${lower(var.environment)}" : null)
    generate_name = var.secret_generate_name != null ? (var.secret_name == "" ? var.secret_generate_name : null) : null

    annotations = var.secret_annotations
    labels      = var.secret_labels
    namespace   = var.secret_namespace
  }

  type = var.secret_type
  data = var.secret_data

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
