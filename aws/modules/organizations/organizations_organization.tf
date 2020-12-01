#---------------------------------------------------
# AWS organizations organizational
#---------------------------------------------------
resource "aws_organizations_organization" "organizations_organization" {
  count = var.enable_organizations_organization ? 1 : 0

  aws_service_access_principals = var.organizations_organization_aws_service_access_principals
  enabled_policy_types          = var.organizations_organization_enabled_policy_types
  feature_set                   = upper(var.organizations_organization_feature_set)

  lifecycle {
    create_before_destroy = false
    ignore_changes        = []
  }

  depends_on = []
}