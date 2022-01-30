#---------------------------------------------------
# AWS Appmesh route
#---------------------------------------------------
resource "aws_appmesh_route" "appmesh_route" {
  count = var.enable_appmesh_route ? 1 : 0

  name                = var.appmesh_route_name != "" ? lower(var.appmesh_route_name) : "${lower(var.name)}-appmesh-route-${lower(var.environment)}"
  mesh_name           = var.appmesh_route_mesh_name != "" ? var.appmesh_route_mesh_name : element(concat(aws_appmesh_mesh.appmesh_mesh.*.id, [""]), 0)
  virtual_router_name = var.appmesh_route_virtual_router_name != "" && !var.enable_appmesh_virtual_router ? var.appmesh_route_virtual_router_name : element(concat(aws_appmesh_virtual_router.appmesh_virtual_router.*.name, [""]), 0)

  spec {
    priority = var.appmesh_route_spec_priority

    dynamic "http_route" {
      iterator = httproute
      for_each = var.appmesh_route_http_route

      content {
        match {
          prefix = lookup(httproute.value, "prefix", "/")

          method = lookup(httproute.value, "method", null)
          scheme = lookup(httproute.value, "scheme", null)
        }

        action {
          weighted_target {
            virtual_node = lookup(httproute.value, "virtual_node", "aws_appmesh_virtual_node_name")
            weight       = lookup(httproute.value, "weight", 10)
          }
        }
      }
    }

    dynamic "http_route" {
      iterator = httproute
      for_each = var.appmesh_route_http_route_header

      content {
        match {
          prefix = lookup(httproute.value, "prefix", "/")

          method = lookup(httproute.value, "method", null)
          scheme = lookup(httproute.value, "scheme", null)
          header {
            name = lookup(httproute.value, "header_name", null)
          }
        }

        action {
          weighted_target {
            virtual_node = lookup(httproute.value, "virtual_node", "aws_appmesh_virtual_node_name")
            weight       = lookup(httproute.value, "weight", 10)
          }
        }
      }
    }

    dynamic "http_route" {
      iterator = httproute
      for_each = var.appmesh_route_http_route_header_match

      content {
        match {
          prefix = lookup(httproute.value, "prefix", "/")

          method = lookup(httproute.value, "method", null)
          scheme = lookup(httproute.value, "scheme", null)
          header {
            name = lookup(httproute.value, "header_name", null)

            match {
              exact  = lookup(httproute.value, "match_exact", null)
              prefix = lookup(httproute.value, "match_prefix", null)
              regex  = lookup(httproute.value, "match_regex", null)
              suffix = lookup(httproute.value, "match_suffix", null)
            }
          }
        }

        action {
          weighted_target {
            virtual_node = lookup(httproute.value, "virtual_node", "aws_appmesh_virtual_node_name")
            weight       = lookup(httproute.value, "weight", 10)
          }
        }
      }
    }

    dynamic "http_route" {
      iterator = httproute
      for_each = var.appmesh_route_http_route_header_match_range

      content {
        match {
          prefix = lookup(httproute.value, "prefix", "/")

          method = lookup(httproute.value, "method", null)
          scheme = lookup(httproute.value, "scheme", null)
          header {
            name = lookup(httproute.value, "header_name", null)

            match {
              exact  = lookup(httproute.value, "match_exact", null)
              prefix = lookup(httproute.value, "match_prefix", null)
              regex  = lookup(httproute.value, "match_regex", null)
              suffix = lookup(httproute.value, "match_suffix", null)
              range {
                start = lookup(httproute.value, "match_range_start", null)
                end   = lookup(httproute.value, "match_range_end", null)
              }
            }
          }
        }

        action {
          weighted_target {
            virtual_node = lookup(httproute.value, "virtual_node", "aws_appmesh_virtual_node_name")
            weight       = lookup(httproute.value, "weight", 10)
          }
        }
      }
    }

    dynamic "tcp_route" {
      iterator = tcproute
      for_each = var.appmesh_route_tcp_route

      content {
        action {
          weighted_target {
            virtual_node = lookup(tcproute.value, "virtual_node", "aws_appmesh_virtual_node_name")
            weight       = lookup(tcproute.value, "weight", 100)
          }
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.appmesh_route_name != "" ? lower(var.appmesh_route_name) : "${lower(var.name)}-appmesh-route-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_appmesh_mesh.appmesh_mesh,
    aws_appmesh_virtual_router.appmesh_virtual_router
  ]
}
