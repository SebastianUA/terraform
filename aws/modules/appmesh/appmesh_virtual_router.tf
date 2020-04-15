#---------------------------------------------------
# AWS Appmesh virtual router
#---------------------------------------------------
resource "aws_appmesh_virtual_router" "appmesh_virtual_router" {
    count           = var.enable_appmesh_virtual_router ? 1 : 0

    name            = var.appmesh_virtual_router_name != "" ? lower(var.appmesh_virtual_service_name) : "${lower(var.name)}-appmesh-virt-router-${lower(var.environment)}"
    mesh_name       = var.appmesh_virtual_router_mesh_name != "" ? var.appmesh_virtual_service_mesh_name : element(concat(aws_appmesh_mesh.appmesh_mesh.*.id, [""]), 0)

    spec {
        listener {
            port_mapping {
                port     = var.appmesh_virtual_router_spec_listener_port_mapping_port
                protocol = lower(var.appmesh_virtual_router_spec_listener_port_mapping_protocol)
            }
        }
    }

    tags            = merge(
        {
            "Name" = var.appmesh_virtual_router_name != "" ? lower(var.appmesh_virtual_service_name) : "${lower(var.name)}-appmesh-virt-router-${lower(var.environment)}"
        },
        var.tags
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on      = [
        aws_appmesh_mesh.appmesh_mesh
    ]
}
