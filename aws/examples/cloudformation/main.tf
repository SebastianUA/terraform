terraform {
  required_version = "~> 0.15"
}

provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = pathexpand("~/.aws/credentials")
  profile                 = "default"
}

#module "AWSCloudFormationStackSetExecutionRole" {
#    source                                          = "../../modules/iam_role"
#    name                                            = "TEST"
#    environment                                     = "stage"
#
#    # Using IAM role
#    enable_iam_role                                 = true
#    iam_role_name                                   = "AWSCloudFormationStackSetExecutionRole"
#    iam_role_description                            = "Role for cloudformation"
#    assume_role_policy                              = file("additional_files/AWSCloudFormationStackSetExecutionRole-assume_role_policy.json")
#
#    iam_role_force_detach_policies                  = true
#    iam_role_path                                   = "/"
#    iam_role_max_session_duration                   = 3600
#
#    # Using IAM role policy
#    enable_iam_role_policy                          = true
#    iam_role_policy_name                            = "AWSCloudFormationStackSetExecutionRole"
#    iam_role_policy                                 = file("additional_files/AWSCloudFormationStackSetExecutionRole-policy.json")
#
#    # Using IAM instance profile
#    enable_iam_instance_profile                     = true
#    iam_instance_profile_name                       = "AWSCloudFormationStackSetExecutionRole-instance-profile"
#}

module "iam_role" {
  source      = "../../modules/iam_role"
  name        = "TEST"
  environment = "stage"

  # Using IAM role
  enable_iam_role      = true
  iam_role_name        = "cloudformation-role"
  iam_role_description = "Role for cloudformation"
  assume_role_policy   = file("additional_files/assume_role_policy.json")

  iam_role_force_detach_policies = true
  iam_role_path                  = "/"
  iam_role_max_session_duration  = 3600

  # Using IAM role policy
  enable_iam_role_policy = true
  iam_role_policy_name   = "cloudformation-policy"
  iam_role_policy        = file("additional_files/policy.json")

  # Using IAM instance profile
  enable_iam_instance_profile = true
  iam_instance_profile_name   = "cloudformation-instance-profile"
}

module "cloudformation" {
  source      = "../../modules/cloudformation"
  name        = "TEST"
  environment = "stage"
  region      = "us-east-1"

  enable_cloudformation_stack        = true
  cloudformation_stack_name          = ""
  cloudformation_stack_template_body = file("additional_files/template_body.json")
  cloudformation_stack_parameters = merge(
    {
      VPCCidr = "10.0.0.0/16"
    },
  )


  enable_cloudformation_stack_set                  = true
  cloudformation_stack_set_name                    = ""
  cloudformation_stack_set_administration_role_arn = module.iam_role.iam_role_arn
  cloudformation_stack_set_template_body           = file("additional_files/template_body.json")
  cloudformation_stack_set_parameters = merge(
    {
      VPCCidr = "10.0.0.0/16"
    },
  )

  enable_cloudformation_stack_set_instance = true

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

}
