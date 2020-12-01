#---------------------------------------------------
# AWS organizations account
#---------------------------------------------------
resource "aws_organizations_account" "organizations_account" {
  count = var.enable_organizations_account ? 1 : 0

  name  = var.organizations_account_name != "" ? var.organizations_account_name : "${lower(var.name)}-org-acc-${lower(var.environment)}"
  email = var.organizations_account_email

  iam_user_access_to_billing = var.organizations_account_iam_user_access_to_billing
  parent_id                  = var.organizations_account_parent_id != null ? var.organizations_account_parent_id : aws_organizations_organization.organizations_organization[0].roots[0].id
  role_name                  = var.organizations_account_role_name

  tags = merge(
    {
      Name = var.organizations_account_name != "" ? var.organizations_account_name : "${lower(var.name)}-org-acc-${lower(var.environment)}"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = [
    aws_organizations_organization.organizations_organization
  ]
}