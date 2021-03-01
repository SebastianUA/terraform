#---------------------------------------------------
# AWS organizations policy attachment
#---------------------------------------------------
resource "aws_organizations_policy_attachment" "organizations_policy_attachment" {
  count = var.enable_organizations_policy_attachment ? 1 : 0

  policy_id = var.organizations_policy_attachment_policy_id != "" ? var.organizations_policy_attachment_policy_id : (var.enable_organizations_policy ? aws_organizations_policy.organizations_policy[0].id : null)
  target_id = var.organizations_policy_attachment_target_id != "" ? var.organizations_policy_attachment_target_id : (var.enable_organizations_organization ? aws_organizations_organization.organizations_organization[0].roots[0].id : (var.enable_organizations_organizational_unit ? aws_organizations_organizational_unit.organizations_organizational_unit[0].id : null))

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
    aws_organizations_policy.organizations_policy,
    aws_organizations_organization.organizations_organization
  ]
}