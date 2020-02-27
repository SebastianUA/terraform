#---------------------------------------------------
# AWS athena workgroup
#---------------------------------------------------
resource "aws_athena_workgroup" "athena_workgroup" {
    count               = var.enable_athena_workgroup ? 1 : 0

    name                = var.athena_workgroup_name != "" ? lower(var.athena_workgroup_name) : "${lower(var.name)}-athena-workgroup-${lower(var.environment)}"
    description         = var.athena_workgroup_description
    state               = upper(var.athena_workgroup_state)

    configuration {
        bytes_scanned_cutoff_per_query      = var.athena_workgroup_bytes_scanned_cutoff_per_query
        enforce_workgroup_configuration     = var.athena_workgroup_enforce_workgroup_configuration
        publish_cloudwatch_metrics_enabled  = var.athena_workgroup_publish_cloudwatch_metrics_enabled

        result_configuration {
            output_location = var.athena_workgroup_output_location != null ? var.athena_workgroup_output_location : null

            encryption_configuration {
                encryption_option = var.athena_workgroup_encryption_option
                kms_key_arn       = var.athena_workgroup_kms_key_arn
            }
        }
    }

    tags                = merge(
        {
            "Name"          = var.athena_workgroup_name != "" ? lower(var.athena_workgroup_name) : "${lower(var.name)}-athena-workgroup-${lower(var.environment)}"
        },
        {
            "Environment"   = var.environment
        },
        {
            "Orchestration" = var.orchestration
        },
        {
            "Createdby"     = var.createdby
        },
        var.tags,
    )

    lifecycle {
        create_before_destroy   = true
        ignore_changes          = []
    }

    depends_on          = []
}
