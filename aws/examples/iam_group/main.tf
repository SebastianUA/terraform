#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = ">= 0.12.12"
}

provider "aws" {
    region  = "us-east-1"
    profile = "default"
}

module "iam_group" {
    source                                  = "../../modules/iam_group"
    name                                    = "TEST-iam-group"
    environment                             = "PROD"

    # Using IAM group 
    enable_iam_group                        = true
    iam_group_name                          = ""
    iam_group_path                          = "/"

    # Using IAM group policy
    enable_iam_group_policy                 = true
    iam_group_policy_name                   = "test-policy"
    iam_group_policy                        = file("additional_files/policy.json")

    # Using IAM group policy attachment 
    #enable_iam_group_policy_attachment      = true
    #iam_group_policy_attachment_policy_arn  = ""
    
    # Using IAM group membership
    enable_iam_group_membership             = true
    iam_group_membership_name               = ""
    iam_group_membership_users              = []
}
