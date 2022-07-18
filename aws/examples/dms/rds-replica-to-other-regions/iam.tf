#---------------------------------------------------------------
# AWS IAM
#---------------------------------------------------------------

# Database Migration Service requires the below IAM Roles to be created before
# replication instances can be created. See the DMS Documentation for
# additional information: https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Security.html#CHAP_Security.APIRole
#  * dms-vpc-role
#  * dms-cloudwatch-logs-role
#  * dms-access-for-endpoint

data "aws_iam_policy_document" "dms_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["dms.amazonaws.com"]
      type        = "Service"
    }
  }
}

# dms-access-for-endpoint
module "dms-access-for-endpoint" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/iam_role?ref=dev"

  name        = local.name
  environment = local.environment

  # Using IAM role
  enable_iam_role             = true
  iam_role_name               = "${local.name}-${local.environment}-dms-access-for-endpoint-role"
  iam_role_description        = "It's IAM role of DMS access for endpoint"
  iam_role_assume_role_policy = data.aws_iam_policy_document.dms_assume_role.json

  iam_role_force_detach_policies = true
  iam_role_path                  = "/"
  iam_role_max_session_duration  = 3600

  # Using IAM role policy attachment
  enable_iam_role_policy_attachment = true
  iam_role_policy_attachment_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonDMSRedshiftS3Role"
  ]

  tags = local.tags
}

# dms-cloudwatch-logs-role
module "dms-cloudwatch-logs-role" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/iam_role?ref=dev"

  name        = local.name
  environment = local.environment

  # Using IAM role
  enable_iam_role             = true
  iam_role_name               = "${local.name}-${local.environment}-dms-cloudwatch-logs-role"
  iam_role_description        = "It's IAM role of DMS for cloudwatch logs role"
  iam_role_assume_role_policy = data.aws_iam_policy_document.dms_assume_role.json

  iam_role_force_detach_policies = true
  iam_role_path                  = "/"
  iam_role_max_session_duration  = 3600

  # Using IAM role policy attachment
  enable_iam_role_policy_attachment = true
  iam_role_policy_attachment_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonDMSCloudWatchLogsRole"
  ]

  tags = local.tags
}

# dms-vpc-role
module "dms-vpc-role" {
  source = "git@github.com:SebastianUA/terraform.git//aws/modules/iam_role?ref=dev"

  name        = local.name
  environment = local.environment

  # Using IAM role
  enable_iam_role             = true
  iam_role_name               = "${local.name}-${local.environment}-dms-vpc-role"
  iam_role_description        = "It's IAM role of DMS for VPC role"
  iam_role_assume_role_policy = data.aws_iam_policy_document.dms_assume_role.json

  iam_role_force_detach_policies = true
  iam_role_path                  = "/"
  iam_role_max_session_duration  = 3600

  # Using IAM role policy attachment
  enable_iam_role_policy_attachment = true
  iam_role_policy_attachment_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonDMSVPCManagementRole"
  ]

  tags = local.tags
}