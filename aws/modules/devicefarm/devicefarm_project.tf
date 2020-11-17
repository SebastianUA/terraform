#---------------------------------------------------
# AWS devicefarm project
#---------------------------------------------------
resource "aws_devicefarm_project" "devicefarm_project" {
  count = var.enable_devicefarm_project ? 1 : 0

  name = var.devicefarm_project_name != "" ? lower(var.devicefarm_project_name) : "${lower(var.name)}-devicefarm-project-${lower(var.environment)}"

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
