#---------------------------------------------------
# AWS Appmesh virtual service
#---------------------------------------------------
resource "aws_appmesh_virtual_service" "appmesh_virtual_service" {
  count = var.enable_appmesh_virtual_service ? 1 : 0

  name      = var.appmesh_virtual_service_name != "" ? lower(var.appmesh_virtual_service_name) : "${lower(var.name)}-appmesh-virt-service-${lower(var.environment)}"
  mesh_name = var.appmesh_virtual_service_mesh_name != "" ? var.appmesh_virtual_service_mesh_name : element(concat(aws_appmesh_mesh.appmesh_mesh.*.id, [""]), 0)

  spec {
    provider {
      dynamic "virtual_node" {
        iterator = virtnode
        for_each = var.appmesh_virtual_service_spec_provider_virtual_node

        content {
          virtual_node_name = lookup(virtnode.value, "virtual_node_name", "aws_appmesh_virtual_node_name")
        }
      }

      dynamic "virtual_router" {
        iterator = virtrouter
        for_each = var.appmesh_virtual_service_spec_provider_virtual_router

        content {
          virtual_router_name = lookup(virtrouter.value, "virtual_router_name", "aws_appmesh_virtual_router_name")
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.appmesh_virtual_service_name != "" ? lower(var.appmesh_virtual_service_name) : "${lower(var.name)}-appmesh-virt-service-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_appmesh_mesh.appmesh_mesh
  ]
}
