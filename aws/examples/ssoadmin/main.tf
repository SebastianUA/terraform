#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

data "aws_ssoadmin_instances" "ssoadmin" {}

data "aws_ssoadmin_permission_set" "ssoadmin" {
  instance_arn = tolist(data.aws_ssoadmin_instances.ssoadmin.arns)[0]
  name         = "AWSReadOnlyAccess"
}

data "aws_identitystore_group" "ssoadmin" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.ssoadmin.identity_store_ids)[0]

  filter {
    attribute_path  = "DisplayName"
    attribute_value = "ssoadminGroup"
  }
}

data "aws_iam_policy_document" "ssoadmin" {
  statement {
    sid = "1"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

module "ssoadmin" {
  source      = "../../modules/ssoadmin"
  name        = "TEST"
  environment = "stage"

  # SSO admin account assignment
  enable_ssoadmin_account_assignment = true

  ssoadmin_account_assignment_instance_arn       = data.aws_ssoadmin_permission_set.ssoadmin.instance_arn
  ssoadmin_account_assignment_permission_set_arn = data.aws_ssoadmin_permission_set.ssoadmin.arn

  ssoadmin_account_assignment_principal_id   = data.aws_identitystore_group.ssoadmin.group_id
  ssoadmin_account_assignment_principal_type = "GROUP"

  ssoadmin_account_assignment_target_id   = "012347678910"
  ssoadmin_account_assignment_target_type = "AWS_ACCOUNT"

  # SSO admin permission set
  enable_ssoadmin_permission_set           = true
  ssoadmin_permission_set_name             = ""
  ssoadmin_permission_set_description      = "An ssoadmin"
  ssoadmin_permission_set_instance_arn     = tolist(data.aws_ssoadmin_instances.ssoadmin.arns)[0]
  ssoadmin_permission_set_relay_state      = "https://s3.console.aws.amazon.com/s3/home?region=us-east-1#"
  ssoadmin_permission_set_session_duration = "PT2H"

  # SSO admin managed policy attachment
  enable_ssoadmin_managed_policy_attachment              = true
  ssoadmin_managed_policy_attachment_managed_policy_arns = ["arn:aws:iam::aws:policy/AlexaForBusinessDeviceSetup"]

  # SSO admin permission set inline policy
  enable_ssoadmin_permission_set_inline_policy          = true
  ssoadmin_permission_set_inline_policy_inline_policies = [data.aws_iam_policy_document.ssoadmin.json]

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}
