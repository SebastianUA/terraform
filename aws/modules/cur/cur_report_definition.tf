#---------------------------------------------------
# AWS cur report definition
#---------------------------------------------------
resource "aws_cur_report_definition" "cur_report_definition" {
  count = var.enable_cur_report_definition ? 1 : 0

  report_name                = var.cur_report_definition_report_name != "" ? lower(var.cur_report_definition_report_name) : "${lower(var.name)}-cur-report-definition-${lower(var.environment)}"
  time_unit                  = upper(var.cur_report_definition_time_unit)
  format                     = var.cur_report_definition_format
  compression                = upper(var.cur_report_definition_compression)
  additional_schema_elements = var.cur_report_definition_additional_schema_elements
  additional_artifacts       = var.cur_report_definition_additional_artifacts
  s3_bucket                  = var.cur_report_definition_s3_bucket
  s3_region                  = var.cur_report_definition_s3_region

  s3_prefix = var.cur_report_definition_s3_prefix

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
