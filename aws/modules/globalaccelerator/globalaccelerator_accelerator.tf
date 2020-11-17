#---------------------------------------------------
# AWS globalaccelerator accelerator
#---------------------------------------------------
resource "aws_globalaccelerator_accelerator" "globalaccelerator_accelerator" {
  count = var.enable_globalaccelerator_accelerator ? 1 : 0

  name = var.globalaccelerator_accelerator_name != "" ? lower(var.globalaccelerator_accelerator_name) : "${lower(var.name)}-globalaccelerator-accelerator-${lower(var.environment)}"

  ip_address_type = upper(var.globalaccelerator_accelerator_ip_address_type)
  enabled         = var.globalaccelerator_accelerator_enabled

  dynamic "attributes" {
    iterator = attributes
    for_each = var.globalaccelerator_accelerator_attributes
    content {
      flow_logs_enabled   = lookup(attributes.value, "flow_logs_enabled", null)
      flow_logs_s3_bucket = lookup(attributes.value, "flow_logs_s3_bucket", null)
      flow_logs_s3_prefix = lookup(attributes.value, "flow_logs_s3_prefix", null)
    }
  }

  tags = merge(
    {
      "Name" = var.globalaccelerator_accelerator_name != "" ? lower(var.globalaccelerator_accelerator_name) : "${lower(var.name)}-globalaccelerator-accelerator-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
