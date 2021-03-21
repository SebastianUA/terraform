#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 0.14"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "organizations" {
  source      = "../../modules/organizations"
  name        = "TEST"
  environment = "stage"

  # AWS Org 
  enable_organizations_organization                        = true
  organizations_organization_aws_service_access_principals = ["ALL"]
  organizations_organization_enabled_policy_types          = ["SERVICE_CONTROL_POLICY", "BACKUP_POLICY", "TAG_POLICY"]
  organizations_organization_feature_set                   = "ALL"

  # AWS Org account
  enable_organizations_account = true
  organizations_account_name   = ""
  organizations_account_email  = "solo.metal@bigmir.net"

  # AWS Org unit
  enable_organizations_organizational_unit    = true
  organizations_organizational_unit_name      = ""
  organizations_organizational_unit_parent_id = ""

  # AWS Org policy
  enable_organizations_policy      = true
  organizations_policy_name        = ""
  organizations_policy_content     = file("additional_files/org_policy_content.json")
  organizations_policy_description = "Allow ALL"
  organizations_policy_type        = "SERVICE_CONTROL_POLICY"

  # AWS Org policy attachment
  enable_organizations_policy_attachment    = true
  organizations_policy_attachment_policy_id = ""
  organizations_policy_attachment_target_id = ""

  tags = merge(map(
    "Createdby", "Vitaliy Natarov",
    "Env", "dev"
  ))
}
