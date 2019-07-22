#---------------------------------------------------
# Create aws msk cluster configuration
#---------------------------------------------------
resource "aws_msk_configuration" "msk_configuration" {
    count               = "${var.enable_msk_configuration ? 1 : 0}"

    name                = "${var.msk_configuration_name !="" ? var.msk_configuration_name : "${lower(var.name)}-msk-cluster-configuration-${lower(var.environment)}" }"
    kafka_versions      = ["2.1.0"]

    description         = "${var.msk_configuration_description}"
    
    server_properties   = ["${var.server_properties}"]
}

