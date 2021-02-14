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
    for_each = var.ssm_patch_baseline_global_filter
    content {
      key    = lookup(ssm_patch_baseline_global_filter.value, "key", null)
      values = lookup(ssm_patch_baseline_global_filter.value, "values", null)
    }
  }

  approval_rule {
    approve_after_days  = var.ssm_patch_baseline_approval_rule_approve_after_days
    compliance_level    = upper(var.ssm_patch_baseline_approval_rule_compliance_level)
    enable_non_security = var.ssm_patch_baseline_approval_rule_enable_non_security

    patch_filter {
      key    = var.ssm_patch_baseline_patch_filter_key
      values = var.ssm_patch_baseline_patch_filter_values
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
