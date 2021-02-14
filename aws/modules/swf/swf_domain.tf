#---------------------------------------------------
# AWS swf domain
#---------------------------------------------------
resource "aws_swf_domain" "swf_domain" {
  count = var.enable_swf_domain ? 1 : 0

  name                                        = var.swf_domain_name != "" && var.swf_domain_name_prefix == "" ? lower(var.swf_domain_name) : null
  name_prefix                                 = var.swf_domain_name_prefix != "" && var.swf_domain_name == "" ? lower(var.swf_domain_name_prefix) : null
  description                                 = var.swf_domain_description
  workflow_execution_retention_period_in_days = var.swf_domain_workflow_execution_retention_period_in_days

  tags = merge(
    {
      Name = var.swf_domain_name != "" && var.swf_domain_name_prefix == "" ? lower(var.swf_domain_name) : lower(var.swf_domain_name_prefix)
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
