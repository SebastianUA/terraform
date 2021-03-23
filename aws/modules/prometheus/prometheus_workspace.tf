#---------------------------------------------------
# AWS prometheus workspace
#---------------------------------------------------
resource "aws_prometheus_workspace" "prometheus_workspace" {
  count = var.enable_prometheus_workspace ? 1 : 0

  alias = var.prometheus_workspace_alias != "" ? var.prometheus_workspace_alias : "${lower(var.name)}-prometheus-workspace-${lower(var.environment)}"

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = []
}