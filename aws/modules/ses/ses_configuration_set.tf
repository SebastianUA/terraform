#---------------------------------------------------
# AWS ses configuration set
#---------------------------------------------------
resource "aws_ses_configuration_set" "ses_configuration_set" {
  count = var.enable_ses_configuration_set ? 1 : 0

  name = var.ses_configuration_set_name != "" ? var.ses_configuration_set_name : "${lower(var.name)}-ses-configuration-set-${lower(var.environment)}"

  reputation_metrics_enabled = var.ses_configuration_set_reputation_metrics_enabled
  sending_enabled            = var.ses_configuration_set_sending_enabled

  dynamic "delivery_options" {
    iterator = delivery_options
    for_each = length(keys(var.ses_configuration_set_delivery_options)) > 0 ? [var.ses_configuration_set_delivery_options] : []

    content {
      tls_policy = lookup(delivery_options.value, "tls_policy", null)
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}