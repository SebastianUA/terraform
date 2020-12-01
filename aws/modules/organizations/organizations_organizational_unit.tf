#---------------------------------------------------
# AWS organizations organizational unit
#---------------------------------------------------
resource "aws_organizations_organizational_unit" "organizations_organizational_unit" {
  count = var.enable_organizations_organizational_unit ? 1 : 0

  name      = var.organizations_organizational_unit_name != "" ? var.organizations_organizational_unit_name : "${lower(var.name)}-org-unit-${lower(var.environment)}"
  parent_id = var.organizations_organizational_unit_parent_id != "" ? var.organizations_organizational_unit_parent_id : (var.enable_organizations_organization ? aws_organizations_organization.organizations_organization[0].roots[0].id : null)

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
    aws_organizations_organization.organizations_organization
  ]
}