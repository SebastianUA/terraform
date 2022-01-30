#---------------------------------------------------
# AWS Appmesh virtual gateway
#---------------------------------------------------
resource "aws_appmesh_virtual_gateway" "appmesh_virtual_gateway" {
  count = var.enable_appmesh_virtual_gateway ? 1 : 0

  name      = var.appmesh_virtual_gateway_name != "" ? lower(var.appmesh_virtual_gateway_name) : "${lower(var.name)}-appmesh-virt-gateway-${lower(var.environment)}"
  mesh_name = var.appmesh_virtual_gateway_mesh_name != "" ? var.appmesh_virtual_gateway_mesh_name : (var.enable_appmesh_mesh ? element(aws_appmesh_mesh.appmesh_mesh.*.id, 0) : null)

  mesh_owner = var.appmesh_virtual_gateway_mesh_owner

  spec {
    listener {
      dynamic "port_mapping" {
        iterator = port_mapping
        for_each = var.appmesh_virtual_gateway_spec_listener_port_mapping

        content {
          port     = lookup(port_mapping.value, "port", null)
          protocol = lookup(port_mapping.value, "protocol", null)
        }
      }

      dynamic "connection_pool" {
        iterator = connection_pool
        for_each = var.appmesh_virtual_gateway_spec_listener_connection_pool

        content {
          grpc {
            max_requests = lookup(connection_pool.value, "grpc_max_requests", null)
          }

          http {
            max_connections      = lookup(connection_pool.value, "http_max_connections", null)
            max_pending_requests = lookup(connection_pool.value, "http_max_pending_requests", null)

          }

          http2 {
            max_requests = lookup(connection_pool.value, "http2_max_requests", null)
          }
        }
      }

      dynamic "health_check" {
        iterator = health_check
        for_each = var.appmesh_virtual_gateway_spec_listener_health_check

        content {
          healthy_threshold   = lookup(health_check.value, "healthy_threshold", null)
          interval_millis     = lookup(health_check.value, "interval_millis", null)
          protocol            = lookup(health_check.value, "protocol", null)
          timeout_millis      = lookup(health_check.value, "timeout_millis", null)
          unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)

          path = lookup(health_check.value, "path", null)
          port = lookup(health_check.value, "port", null)
        }
      }

      dynamic "tls" {
        iterator = tls
        for_each = var.appmesh_virtual_gateway_spec_listener_tls

        content {
          certificate {
            acm {
              certificate_arn = lookup(tls.value, "certificate_arn", null)
            }

            file {
              certificate_chain = lookup(tls.value, "certificate_chain", null)
              private_key       = lookup(tls.value, "private_key", null)
            }
          }
          mode = lookup(tls.value, "mode", null)
        }
      }

    }

    dynamic "backend_defaults" {
      iterator = backend_defaults
      for_each = var.appmesh_virtual_gateway_spec_backend_defaults

      content {
        client_policy {
          tls {
            enforce = lookup(backend_defaults.value, "tls_enforce", null)
            ports   = lookup(backend_defaults.value, "tls_ports", null)

            validation {
              trust {
                acm {
                  certificate_authority_arns = lookup(backend_defaults.value, "certificate_authority_arns", null)
                }

                file {
                  certificate_chain = lookup(backend_defaults.value, "certificate_chain", null)
                }
              }
            }
          }
        }
      }
    }

    dynamic "logging" {
      iterator = logging
      for_each = var.appmesh_virtual_gateway_spec_logging

      content {
        access_log {
          file {
            path = lookup(logging.value, "access_log_file_path", null)
          }
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.appmesh_virtual_gateway_name != "" ? lower(var.appmesh_virtual_gateway_name) : "${lower(var.name)}-appmesh-virt-gateway-${lower(var.environment)}"
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

