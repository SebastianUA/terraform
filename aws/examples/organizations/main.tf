#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = [pathexpand("~/.aws/credentials")]
}

data "aws_organizations_organization" "current" {}

data "aws_organizations_organizational_units" "ou" {
  parent_id = data.aws_organizations_organization.current.roots[0].id
}

module "org" {
  source      = "../../modules/organizations"
  name        = "TEST"
  environment = "stage"

  # AWS Org 
  enable_organizations_organization                        = false
  organizations_organization_aws_service_access_principals = ["ALL"]
  organizations_organization_enabled_policy_types          = ["SERVICE_CONTROL_POLICY", "BACKUP_POLICY", "TAG_POLICY"]
  organizations_organization_feature_set                   = "ALL"

  # AWS Org policy
  enable_organizations_policy      = false
  organizations_policy_name        = ""
  organizations_policy_content     = file("additional_files/org_policy_content.json")
  organizations_policy_description = "Allow ALL"
  organizations_policy_type        = "SERVICE_CONTROL_POLICY"

  # AWS Org policy attachment
  enable_organizations_policy_attachment    = false
  organizations_policy_attachment_policy_id = ""
  organizations_policy_attachment_target_id = ""

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = []
}

module "org_unit" {
  source      = "../../modules/organizations"
  name        = "TEST"
  environment = "stage"

  # AWS Org unit
  enable_organizations_organizational_unit    = true
  organizations_organizational_unit_name      = ""
  organizations_organizational_unit_parent_id = data.aws_organizations_organization.current.roots[0].id # data.aws_organizations_organizational_units.ou.id

  # AWS Org policy
  enable_organizations_policy      = true
  organizations_policy_name        = ""
  organizations_policy_content     = file("additional_files/org_policy_content.json")
  organizations_policy_description = "Allow ALL"
  organizations_policy_type        = "SERVICE_CONTROL_POLICY"

  # AWS Org policy attachment
  enable_organizations_policy_attachment    = false
  organizations_policy_attachment_policy_id = ""
  organizations_policy_attachment_target_id = ""

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    data.aws_organizations_organizational_units.ou,
    module.org
  ]
}

module "org_account" {
  source      = "../../modules/organizations"
  name        = "TEST"
  environment = "stage"

  # AWS Org account
  enable_organizations_account    = true
  organizations_account_name      = ""
  organizations_account_parent_id = module.org_unit.organizations_organizational_unit_id
  organizations_account_email     = "solo.metal@bigmir.net"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.org_unit
  ]
}
