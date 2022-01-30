#---------------------------------------------------
# AWS Appmesh virtual node
#---------------------------------------------------
resource "aws_appmesh_virtual_node" "appmesh_virtual_node" {
  count = var.enable_appmesh_virtual_node ? 1 : 0

  name      = var.appmesh_virtual_node_name != "" ? lower(var.appmesh_virtual_node_name) : "${lower(var.name)}-appmesh-virt-node-${lower(var.environment)}"
  mesh_name = var.appmesh_virtual_node_mesh_name != "" ? var.appmesh_virtual_node_mesh_name : element(concat(aws_appmesh_mesh.appmesh_mesh.*.id, [""]), 0)

  spec {
    dynamic "backend" {
      iterator = backend
      for_each = var.appmesh_virtual_node_backend

      content {
        virtual_service {
          virtual_service_name = lookup(backend.value, "virtual_service_name", "servicea.simpleapp.local")
        }
      }
    }

    dynamic "listener" {
      iterator = listener
      for_each = var.appmesh_virtual_node_listener

      content {
        port_mapping {
          port     = lookup(listener.value, "port", 8080)
          protocol = lookup(listener.value, "protocol", "http")
        }
      }
    }

    dynamic "listener" {
      iterator = listener
      for_each = var.appmesh_virtual_node_listener_hc

      content {
        port_mapping {
          port     = lookup(listener.value, "pm_port", 8080)
          protocol = lookup(listener.value, "pm_protocol", "http")
        }

        health_check {
          healthy_threshold   = lookup(listener.value, "hc_healthy_threshold", 2)
          interval_millis     = lookup(listener.value, "hc_interval_millis", 5000)
          protocol            = lookup(listener.value, "hc_protocol", "http")
          timeout_millis      = lookup(listener.value, "hc_timeout_millis", 2000)
          unhealthy_threshold = lookup(listener.value, "hc_unhealthy_threshold", 2)

          path = lookup(listener.value, "hc_path", null)
          port = lookup(listener.value, "hc_port", null)
        }
      }
    }

    dynamic "service_discovery" {
      iterator = servicediscovery
      for_each = var.appmesh_virtual_node_service_discovery_dns

      content {
        dns {
          hostname = lookup(servicediscovery.value, "hostname", "serviceb.simpleapp.local")
        }
      }
    }

    dynamic "service_discovery" {
      iterator = servicediscovery
      for_each = var.appmesh_virtual_node_service_discovery_cloud_map

      content {
        aws_cloud_map {
          service_name   = lookup(servicediscovery.value, "service_name", "serviceb1")
          namespace_name = lookup(servicediscovery.value, "namespace_name", "aws_service_discovery_http_namespace_name")

          attributes = lookup(servicediscovery.value, "attributes", {})
        }
      }
    }

    dynamic "logging" {
      iterator = logging
      for_each = var.appmesh_virtual_node_logging

      content {
        access_log {
          file {
            path = lookup(logging.value, "path", "/dev/stdout")
          }
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.appmesh_virtual_node_name != "" ? lower(var.appmesh_virtual_node_name) : "${lower(var.name)}-appmesh-virt-node-${lower(var.environment)}"
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
