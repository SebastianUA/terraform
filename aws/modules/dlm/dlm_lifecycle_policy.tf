#---------------------------------------------------
# AWS DLM lifecycle_policy
#---------------------------------------------------
resource "aws_dlm_lifecycle_policy" "dlm_lifecycle_policy" {
  count = var.enable_dlm_lifecycle_policy ? 1 : 0

  description        = var.dlm_lifecycle_policy_description != "" ? lower(var.dlm_lifecycle_policy_description) : "A dlm lifecycle policy managing by Terraform"
  execution_role_arn = var.dlm_lifecycle_policy_execution_role_arn
  state              = upper(var.dlm_lifecycle_policy_state)

  policy_details {
    resource_types = var.dlm_lifecycle_policy_details_resource_types

    schedule {
      name = var.dlm_lifecycle_policy_details_schedule_name != "" ? lower(var.dlm_lifecycle_policy_details_schedule_name) : "${lower(var.name)}-schedule-${lower(var.environment)}"

      create_rule {
        interval      = var.dlm_lifecycle_policy_details_schedule_create_rule_interval
        interval_unit = upper(var.dlm_lifecycle_policy_details_schedule_create_rule_interval_unit)
        times         = var.dlm_lifecycle_policy_details_schedule_create_rule_times
      }

      retain_rule {
        count = var.dlm_lifecycle_policy_details_schedule_retain_rule_count
      }

      tags_to_add = merge(
        {
          Name = var.dlm_lifecycle_policy_name != "" ? lower(var.dlm_lifecycle_policy_name) : "${lower(var.name)}-dlm-lifecycle-policy-${lower(var.environment)}"
        },
        var.tags_to_add
      )

      copy_tags = var.dlm_lifecycle_policy_details_schedule_copy_tags
    }

    target_tags = merge(
      {
        Name = var.dlm_lifecycle_policy_name != "" ? lower(var.dlm_lifecycle_policy_name) : "${lower(var.name)}-dlm-lifecycle-policy-${lower(var.environment)}"
      },
      var.target_tags
    )
  }

  tags = merge(
    {
      Name = var.dlm_lifecycle_policy_name != "" ? lower(var.dlm_lifecycle_policy_name) : "${lower(var.name)}-dlm-lifecycle-policy-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
