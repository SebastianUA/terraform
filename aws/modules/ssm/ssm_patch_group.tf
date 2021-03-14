#-----------------------------------------------------------
# AWS SSM patch group
#-----------------------------------------------------------
resource "aws_ssm_patch_group" "ssm_patch_group" {
  count = var.enable_ssm_patch_group ? 1 : 0

  patch_group = var.ssm_patch_group_patch_group != "" ? lower(var.ssm_patch_group_patch_group) : "${lower(var.name)}-patch-group-${lower(var.environment)}"
  baseline_id = var.ssm_patch_group_baseline_id != "" && ! var.enable_ssm_patch_baseline ? var.ssm_patch_group_baseline_id : element(concat(aws_ssm_patch_baseline.ssm_patch_baseline.*.id, [""]), 0)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_ssm_patch_baseline.ssm_patch_baseline
  ]
}
