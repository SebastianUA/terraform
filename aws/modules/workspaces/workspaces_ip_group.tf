#---------------------------------------------------
# AWS Workspaces ip group
#---------------------------------------------------
resource "aws_workspaces_ip_group" "workspaces_ip_group" {
  count = var.enable_workspaces_ip_group ? 1 : 0

  name = var.workspaces_ip_group_name != "" ? var.workspaces_ip_group_name : "${lower(var.name)}-workspaces-ip-group-${lower(var.environment)}"

  description = var.workspaces_ip_group_description

  dynamic "rules" {
    iterator = rules
    for_each = var.workspaces_ip_group_rules

    content {
      source      = lookup(rules.value, "source", null)
      description = lookup(rules.value, "description", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
