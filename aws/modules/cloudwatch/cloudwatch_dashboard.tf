#---------------------------------------------------
# AWS CloudWatch Create AWS dashboard
#---------------------------------------------------
resource "aws_cloudwatch_dashboard" "cw_dashboard" {
  count = var.enable_cw_dashboard ? 1 : 0

  dashboard_name = var.cw_dashboard_name != "" ? var.cw_dashboard_name : "${lower(var.name)}-cw_dashboard-${lower(var.environment)}"
  dashboard_body = var.cw_dashboard_body

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}