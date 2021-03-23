#---------------------------------------------------
# ssoadmin permission set
#---------------------------------------------------
resource "aws_ssoadmin_permission_set" "ssoadmin_permission_set" {
  count = var.enable_ssoadmin_permission_set ? 1 : 0

  name         = var.ssoadmin_permission_set_name != "" ? var.ssoadmin_permission_set_name : "${lower(var.name)}-ssoadmin-permission-set-${lower(var.environment)}"
  instance_arn = var.ssoadmin_permission_set_instance_arn

  description      = var.ssoadmin_permission_set_description
  relay_state      = var.ssoadmin_permission_set_relay_state
  session_duration = var.ssoadmin_permission_set_session_duration

  tags = merge(
    {
      Name = var.ssoadmin_permission_set_name != "" ? var.ssoadmin_permission_set_name : "${lower(var.name)}-ssoadmin-permission-set-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

