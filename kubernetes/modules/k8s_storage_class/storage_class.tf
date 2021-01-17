#---------------------------------------------------
# Kubernetes storage_class
#---------------------------------------------------
resource "kubernetes_storage_class" "storage_class" {
  count = var.enable_storage_class ? 1 : 0

  metadata {
    name          = var.storage_class_name != "" ? var.storage_class_name : (var.storage_class_generate_name == null ? "${lower(var.name)}-sc-${lower(var.environment)}" : null)
    generate_name = var.storage_class_generate_name != null ? (var.storage_class_name == "" ? var.storage_class_generate_name : null) : null

    annotations = var.storage_class_annotations
    labels      = var.storage_class_labels
  }

  storage_provisioner    = var.storage_class_storage_provisioner
  reclaim_policy         = var.storage_class_reclaim_policy
  parameters             = var.storage_class_parameters
  mount_options          = var.storage_class_mount_options
  volume_binding_mode    = var.storage_class_volume_binding_mode
  allow_volume_expansion = var.storage_class_allow_volume_expansion

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
