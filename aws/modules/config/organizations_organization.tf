#---------------------------------------------------
# AWS config organization
#---------------------------------------------------
resource "aws_organizations_organization" "organizations_organization" {
  count = var.enable_organizations_organization ? 1 : 0

  aws_service_access_principals = var.organizations_organization_aws_service_access_principals
  feature_set                   = upper(var.organizations_organization_feature_set)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}
