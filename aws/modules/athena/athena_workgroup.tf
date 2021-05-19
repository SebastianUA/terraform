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

      dynamic "result_configuration" {
        iterator = result_configuration
        for_each = length(keys(lookup(configuration.value, "result_configuration", {}))) > 0 ? [lookup(configuration.value, "result_configuration", {})] : []

        content {
          output_location = lookup(result_configuration.value, "output_location", null)

          dynamic "encryption_configuration" {
            iterator = encryption_configuration
            for_each = length(keys(lookup(result_configuration.value, "encryption_configuration", {}))) > 0 ? [lookup(result_configuration.value, "encryption_configuration", {})] : []

            content {
              encryption_option = lookup(encryption_configuration.value, "encryption_option", null)
              kms_key_arn       = lookup(encryption_configuration.value, "kms_key_arn", null)
            }
          }
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

