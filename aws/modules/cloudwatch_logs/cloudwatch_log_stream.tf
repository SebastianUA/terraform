#---------------------------------------------------
# AWS CloudWatch LOG stream
#---------------------------------------------------
resource "aws_cloudwatch_log_stream" "cw_log_stream" {
  count = var.enable_cw_log_stream ? length(var.cloudwatch_log_stream_names) : 0

  name           = var.cloudwatch_log_stream_names[count.index]
  log_group_name = var.cw_log_group_name != "" ? var.cw_log_group_name : (var.enable_cw_log_group ? element(concat(aws_cloudwatch_log_group.cw_log_group.*.id, [""]), 0) : null)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_cloudwatch_log_group.cw_log_group
  ]
}
