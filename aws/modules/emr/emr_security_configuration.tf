#---------------------------------------------------
# AWS EMR security configuration
#---------------------------------------------------
resource "aws_emr_security_configuration" "emr_security_configuration" {
  count = var.enable_emr_security_configuration ? 1 : 0

  configuration = var.emr_security_configuration_configuration

  name        = var.emr_security_configuration_name
  name_prefix = var.emr_security_configuration_name_prefix

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
