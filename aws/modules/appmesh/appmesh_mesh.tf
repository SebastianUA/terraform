#---------------------------------------------------
# AWS Appmesh mesh
#---------------------------------------------------
resource "aws_appmesh_mesh" "appmesh_mesh" {
  count = var.enable_appmesh_mesh ? 1 : 0

  name = var.appmesh_mesh_name != "" ? lower(var.appmesh_mesh_name) : "${lower(var.name)}-appmesh-mesh-${lower(var.environment)}"

  spec {
    egress_filter {
      type = upper(var.appmesh_mesh_spec_egress_filter_type)
    }
  }

  tags = merge(
    {
      Name = var.appmesh_mesh_name != "" ? lower(var.appmesh_mesh_name) : "${lower(var.name)}-appmesh-mesh-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
