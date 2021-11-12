#---------------------------------------------------
# Data for AWS MQ broker configuration
#---------------------------------------------------
data "template_file" "mq_configuration_data" {
  template = var.mq_configuration_data
}
#---------------------------------------------------
# AWS MQ broker configuration
#---------------------------------------------------
resource "aws_mq_configuration" "mq_configuration" {
  count = var.enable_mq_configuration ? 1 : 0

  name           = var.mq_configuration_name != "" ? var.mq_configuration_name : "${lower(var.name)}-mq-broker-configuration-${lower(var.environment)}"
  description    = var.mq_configuration_description != "" ? var.mq_configuration_description : null
  engine_type    = var.mq_configuration_engine_type
  engine_version = var.mq_configuration_engine_version != "" ? var.mq_configuration_engine_version : lookup(var.mq_brokers, var.mq_configuration_engine_type)
  data           = data.template_file.mq_configuration_data.rendered

  tags = merge(
    {
      Name = var.mq_configuration_name != "" ? var.mq_configuration_name : "${lower(var.name)}-mq-broker-configuration-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    data.template_file.mq_configuration_data
  ]
}
