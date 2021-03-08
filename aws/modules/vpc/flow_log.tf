#---------------------------------------------------
# AWS VPC flow log
#---------------------------------------------------
resource "aws_flow_log" "flow_log" {
  count = var.enable_flow_log ? length(var.flow_log_stack) : 0

  traffic_type = lookup(var.flow_log_stack[count.index], "traffic_type", "ALL")

  eni_id                   = lookup(var.flow_log_stack[count.index], "eni_id", null)
  iam_role_arn             = lookup(var.flow_log_stack[count.index], "iam_role_arn", null)
  log_destination_type     = lookup(var.flow_log_stack[count.index], "log_destination_type", null)
  log_destination          = lookup(var.flow_log_stack[count.index], "log_destination", null)
  subnet_id                = lookup(var.flow_log_stack[count.index], "subnet_id", null)
  vpc_id                   = lookup(var.flow_log_stack[count.index], "vpc_id", (var.enable_vpc ? element(aws_vpc.vpc.*.id, 0) : null))
  log_format               = lookup(var.flow_log_stack[count.index], "log_format", null)
  max_aggregation_interval = lookup(var.flow_log_stack[count.index], "max_aggregation_interval", null)

  tags = merge(
    {
      Name = lookup(var.flow_log_stack[count.index], "name", "${lower(var.name)}-flow-log-${count.index + 1}-${lower(var.environment)}")
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_vpc.vpc
  ]
}
