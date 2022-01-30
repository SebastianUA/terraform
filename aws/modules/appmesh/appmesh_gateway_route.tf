#---------------------------------------------------
# AWS Appmesh gateway route
#---------------------------------------------------
resource "aws_appmesh_gateway_route" "appmesh_gateway_route" {
  count = var.enable_appmesh_gateway_route ? 1 : 0

  name                 = var.appmesh_gateway_route_name != "" ? lower(var.appmesh_gateway_route_name) : "${lower(var.name)}-appmesh-gateway-route-${lower(var.environment)}"
  mesh_name            = var.appmesh_gateway_route_mesh_name != "" ? var.appmesh_gateway_route_mesh_name : (var.enable_appmesh_mesh ? element(aws_appmesh_mesh.appmesh_mesh.*.id, 0) : null)
  virtual_gateway_name = var.appmesh_gateway_route_virtual_gateway_name != "" ? var.appmesh_gateway_route_virtual_gateway_name : (var.enable_appmesh_virtual_gateway ? element(aws_appmesh_virtual_gateway.appmesh_virtual_gateway.*.name, 0) : null)

  mesh_owner = var.appmesh_gateway_route_mesh_owner

  spec {
    dynamic "grpc_route" {
      iterator = grpc_route
      for_each = var.appmesh_gateway_route_spec_grpc_route

      content {
        action {
          target {
            virtual_service {
              virtual_service_name = lookup(grpc_route.value, "virtual_service_name", element(aws_appmesh_virtual_gateway.appmesh_virtual_gateway.*.name, 0))
            }

          }

        }
        match {
          service_name = lookup(grpc_route.value, "service_name", null)
        }
      }
    }

    dynamic "http_route" {
      iterator = http_route
      for_each = var.appmesh_gateway_route_spec_http_route

      content {
        action {
          target {
            virtual_service {
              virtual_service_name = lookup(http_route.value, "virtual_service_name", element(aws_appmesh_virtual_gateway.appmesh_virtual_gateway.*.name, 0))
            }
          }
        }

        match {
          prefix = lookup(http_route.value, "prefix", null)
        }
      }
    }

    dynamic "http2_route" {
      iterator = http2_route
      for_each = var.appmesh_gateway_route_spec_http2_route

      content {
        action {
          target {
            virtual_service {
              virtual_service_name = lookup(http2_route.value, "virtual_service_name", element(aws_appmesh_virtual_gateway.appmesh_virtual_gateway.*.name, 0))
            }
          }

        }
        match {
          prefix = lookup(http2_route.value, "prefix", null)
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.appmesh_gateway_route_name != "" ? lower(var.appmesh_gateway_route_name) : "${lower(var.name)}-appmesh-gateway-route-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_appmesh_mesh.appmesh_mesh,
    aws_appmesh_virtual_gateway.appmesh_virtual_gateway
  ]
}