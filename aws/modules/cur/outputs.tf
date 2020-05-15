#---------------------------------------------------
# AWS cur report definition
#---------------------------------------------------
output "cur_report_definition_id" {
    description = "The ID of the cur report definition"
    value       = element(concat(aws_cur_report_definition.cur_report_definition.*.id, [""], ), 0)
}
