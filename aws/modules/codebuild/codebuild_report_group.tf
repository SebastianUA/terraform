#---------------------------------------------------
# AWS Codebuild report group
#---------------------------------------------------
resource "aws_codebuild_report_group" "codebuild_report_group" {
  count = var.enable_codebuild_report_group ? length(var.codebuild_report_group_stack) : 0

  name = lookup(var.codebuild_report_group_stack[count.index], "name", "${var.name}-codebuild-report-group-${count.index + 1}-${var.environment}")
  type = lookup(var.codebuild_report_group_stack[count.index], "type", null)

  //delete_reports = lookup(var.codebuild_report_group_stack[count.index], "delete_reports", null)

  dynamic "export_config" {
    iterator = export_config
    for_each = length(keys(lookup(var.codebuild_report_group_stack[count.index], "export_config", {}))) > 0 ? [lookup(var.codebuild_report_group_stack[count.index], "export_config", {})] : []

    content {
      type = lookup(export_config.value, "type", null)

      dynamic "s3_destination" {
        iterator = s3_destination
        for_each = length(keys(lookup(export_config.value, "s3_destination", {}))) > 0 ? [lookup(export_config.value, "s3_destination", {})] : []
        content {
          bucket              = lookup(s3_destination.value, "bucket", null)
          encryption_disabled = lookup(s3_destination.value, "encryption_disabled", null)

          encryption_key = lookup(s3_destination.value, "encryption_key", null)
          packaging      = lookup(s3_destination.value, "packaging", null)
          path           = lookup(s3_destination.value, "path", null)
        }
      }
    }
  }

  tags = merge(
    {
      Name = lookup(var.codebuild_report_group_stack[count.index], "name", "${var.name}-codebuild-report-group-${count.index + 1}-${var.environment}")
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
