#-----------------------------------------------------------
# AWS SSM association
#-----------------------------------------------------------
resource "aws_ssm_association" "ssm_association" {
  count = var.enable_ssm_association ? 1 : 0

  name = var.ssm_association_name != "" && !var.enable_ssm_document ? (var.ssm_document_name != "" ? lower(var.ssm_document_name) : "${lower(var.name)}-association-${lower(var.environment)}") : element(concat(aws_ssm_document.ssm_document.*.name, [""]), 0)

  association_name                 = var.ssm_association_association_name
  document_version                 = var.ssm_association_document_version
  instance_id                      = var.ssm_association_instance_id
  parameters                       = var.ssm_association_parameters
  schedule_expression              = var.ssm_association_schedule_expression
  compliance_severity              = upper(var.ssm_association_compliance_severity)
  max_concurrency                  = var.ssm_association_max_concurrency
  max_errors                       = var.ssm_association_max_errors
  automation_target_parameter_name = var.ssm_association_automation_target_parameter_name

  dynamic "output_location" {
    iterator = output_location
    for_each = var.ssm_association_output_location

    content {
      s3_bucket_name = lookup(output_location.value, "s3_bucket_name", null)
      s3_key_prefix  = lookup(output_location.value, "s3_key_prefix", null)
    }
  }

  dynamic "targets" {
    iterator = targets
    for_each = var.ssm_association_targets

    content {
      key    = lookup(targets.value, "key", null)
      values = lookup(targets.value, "values", [])
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ssm_document.ssm_document
  ]
}
