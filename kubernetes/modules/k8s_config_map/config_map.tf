#---------------------------------------------------
# Kubernetes config_map
#---------------------------------------------------
resource "kubernetes_config_map" "config_map" {
  count = var.enable_config_map ? 1 : 0

  metadata {
    name          = var.config_map_name != "" ? var.config_map_name : (var.config_map_generate_name == null ? "${lower(var.name)}-cm-${lower(var.environment)}" : null)
    generate_name = var.config_map_generate_name != null ? (var.config_map_name == "" ? var.config_map_generate_name : null) : null

    annotations = var.config_map_annotations
    labels      = var.config_map_labels

    namespace = var.config_map_namespace
  }

  data        = var.data
  binary_data = var.binary_data

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
