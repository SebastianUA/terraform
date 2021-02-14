#---------------------------------------------------
# AWS athena workgroup
#---------------------------------------------------
resource "aws_athena_workgroup" "athena_workgroup" {
  count = var.enable_athena_workgroup ? 1 : 0

  name = var.athena_workgroup_name != "" ? lower(var.athena_workgroup_name) : "${lower(var.name)}-athena-workgroup-${lower(var.environment)}"

  description   = var.athena_workgroup_description
  state         = upper(var.athena_workgroup_state)
  force_destroy = var.athena_workgroup_force_destroy

  dynamic "configuration" {
    iterator = configuration
    for_each = var.athena_workgroup_configuration
    content {
      bytes_scanned_cutoff_per_query     = lookup(configuration.value, "bytes_scanned_cutoff_per_query", null)
      enforce_workgroup_configuration    = lookup(configuration.value, "enforce_workgroup_configuration", null)
      publish_cloudwatch_metrics_enabled = lookup(configuration.value, "publish_cloudwatch_metrics_enabled", null)

      result_configuration {
        output_location = lookup(configuration.value, "output_location", null)

        encryption_configuration {
          encryption_option = lookup(configuration.value, "encryption_option", null)
          kms_key_arn       = lookup(configuration.value, "kms_key_arn", null)
        }
      }
    }
  }

  tags = merge(
    {
      Name = var.athena_workgroup_name != "" ? lower(var.athena_workgroup_name) : "${lower(var.name)}-athena-workgroup-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

