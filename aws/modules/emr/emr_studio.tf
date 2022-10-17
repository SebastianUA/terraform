#---------------------------------------------------
# AWS EMR studio
#---------------------------------------------------
resource "aws_emr_studio" "emr_studio" {
  count = var.enable_emr_studio_session_mapping ? 1 : 0

  name                        = var.emr_studio_name != "" ? var.emr_studio_name : "${var.name}-emr-studio-${var.environment}"
  auth_mode                   = var.emr_studio_auth_mode
  default_s3_location         = var.emr_studio_default_s3_location
  engine_security_group_id    = var.emr_studio_engine_security_group_id
  service_role                = var.emr_studio_service_role
  subnet_ids                  = var.emr_studio_subnet_ids
  vpc_id                      = var.emr_studio_vpc_id
  workspace_security_group_id = var.emr_studio_workspace_security_group_id

  description                    = var.emr_studio_description
  idp_auth_url                   = var.emr_studio_idp_auth_url
  idp_relay_state_parameter_name = var.emr_studio_idp_relay_state_parameter_name
  user_role                      = var.emr_studio_user_role

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
