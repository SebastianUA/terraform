#---------------------------------------------------
# AWS rolesanywhere profile
#---------------------------------------------------
resource "aws_rolesanywhere_profile" "rolesanywhere_profile" {
  count = var.enable_rolesanywhere_profile ? 1 : 0

  name      = var.rolesanywhere_profile_name != "" ? lower(var.rolesanywhere_profile_name) : "${lower(var.name)}-rolesanywhere-profile-${lower(var.environment)}"
  role_arns = var.rolesanywhere_profile_role_arns

  duration_seconds            = var.rolesanywhere_profile_duration_seconds
  enabled                     = var.rolesanywhere_profile_enabled
  managed_policy_arns         = var.rolesanywhere_profile_managed_policy_arns
  require_instance_properties = var.rolesanywhere_profile_require_instance_properties
  session_policy              = var.rolesanywhere_profile_session_policy

  tags = merge(
    {
      Name = var.rolesanywhere_profile_name != "" ? lower(var.rolesanywhere_profile_name) : "${lower(var.name)}-rolesanywhere-profile-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}