#---------------------------------------------------
# AWS EMR studio session mapping
#---------------------------------------------------
resource "aws_emr_studio_session_mapping" "emr_studio_session_mapping" {
  count = var.enable_emr_studio_session_mapping ? 1 : 0

  studio_id          = var.emr_studio_session_mapping_studio_id ? var.emr_studio_session_mapping_studio_id : (var.enable_emr_studio ? aws_emr_studio.emr_studio[count.index].id : null)
  identity_type      = var.emr_studio_session_mapping_identity_type
  session_policy_arn = var.emr_studio_session_mapping_session_policy_arn

  identity_id   = var.emr_studio_session_mapping_identity_id
  identity_name = var.emr_studio_session_mapping_identity_name

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_emr_studio.emr_studio
  ]
}