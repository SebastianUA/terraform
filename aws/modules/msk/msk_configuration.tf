#---------------------------------------------------
# AWS MSK cluster configuration
#---------------------------------------------------
resource "aws_msk_configuration" "msk_configuration" {
  count = var.enable_msk_configuration ? 1 : 0

  name              = var.msk_configuration_name != "" ? lower(var.msk_configuration_name) : "${lower(var.name)}-msk-cluster-configuration-${lower(var.environment)}"
  kafka_versions    = var.msk_configuration_kafka_versions
  server_properties = var.msk_configuration_server_properties

  description = var.msk_configuration_description

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
