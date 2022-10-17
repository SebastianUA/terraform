#---------------------------------------------------
# AWS EMR containers virtual cluster
#---------------------------------------------------
resource "aws_emrcontainers_virtual_cluster" "emrcontainers_virtual_cluster" {
  count = var.enable_emrcontainers_virtual_cluster ? 1 : 0

  name = var.emrcontainers_virtual_cluster_name != "" ? var.emrcontainers_virtual_cluster_name : "${var.name}-emrcontainers-virtual-cluster-${var.environment}"

  dynamic "container_provider" {
    iterator = container_provider
    for_each = var.emrcontainers_virtual_cluster_container_provider

    content {
      id   = lookup(container_provider.value, "id", null)
      type = lookup(container_provider.value, "type", null)

      dynamic "info" {
        iterator = info
        for_each = length(keys(lookup(container_provider.value, "info", {}))) > 0 ? [lookup(container_provider.value, "info", {})] : []

        content {
          dynamic "eks_info" {
            iterator = eks_info
            for_each = length(keys(lookup(container_provider.value, "eks_info", {}))) > 0 ? [lookup(container_provider.value, "eks_info", {})] : []

            content {
              namespace = lookup(eks_info.value, "namespace", null)
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