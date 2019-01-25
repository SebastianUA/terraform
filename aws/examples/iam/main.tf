#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#
terraform {
  required_version = ">= 0.11.11"
}
provider "aws" {
    region  = "us-east-1"
    profile = "default"
}

module "aim" {
    source                          = "../../modules/iam"
    name                            = "TEST-AIM"
    environment                     = "PROD"

    enable_iam_role                 = true
    # if you would like to set custom name for role, use iam_role_name;
    iam_role_name                   = "test_assume_role2"
    assume_role_policy_file         = "additional_files/policies/test_policy_principal.json"

    enable_iam_instance_profile     = false

    enable_iam_policy               = true
    iam_policy_file                 = "additional_files/policies/test_policy.json"
    enable_iam_policy_attachment    = true

    enable_crossaccount_role        = false
    cross_acc_principal_arns        = ["222222222222222","arn:aws:iam::333333333333:user/test"]
    cross_acc_policy_arns           = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"] 
                                         
    enable_iam_server_certificate   = false
    certificate_body_file           = "additional_files/certs/example.crt.pem"
    private_key_file                = "additional_files/certs/example.key.pem"
}
