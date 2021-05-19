#-----------------------------------------------------------
# AWS SSM patch baseline
#-----------------------------------------------------------
resource "aws_ssm_patch_baseline" "ssm_patch_baseline" {
  count = var.enable_ssm_patch_baseline ? 1 : 0

  name                              = var.ssm_patch_baseline_name != "" ? lower(var.ssm_patch_baseline_name) : "${lower(var.name)}-patch-baseline-${lower(var.environment)}"
  description                       = var.ssm_patch_baseline_description
  operating_system                  = upper(var.ssm_patch_baseline_operating_system)
  approved_patches                  = var.ssm_patch_baseline_approved_patches
  rejected_patches                  = var.ssm_patch_baseline_rejected_patches
  approved_patches_compliance_level = upper(var.ssm_patch_baseline_approved_patches_compliance_level)

  dynamic "global_filter" {
    iterator = global_filter
    for_each = var.ssm_patch_baseline_global_filter

    content {
      key    = lookup(global_filter.value, "key", null)
      values = lookup(global_filter.value, "values", null)
    }
  }

  dynamic "approval_rule" {
    iterator = approval_rule
    for_each = var.ssm_patch_baseline_approval_rule

    content {
      approve_after_days  = lookup(approval_rule.value, "approve_after_days", null)
      compliance_level    = lookup(approval_rule.value, "compliance_level", null)
      enable_non_security = lookup(approval_rule.value, "enable_non_security", null)

      patch_filter {
        key    = lookup(approval_rule.value, "key", null)
        values = lookup(approval_rule.value, "values", null)
      }
    }
  }

  tags = merge(
    {
      Name = var.ssm_patch_baseline_name != "" ? lower(var.ssm_patch_baseline_name) : "${lower(var.name)}-patch-baseline-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
