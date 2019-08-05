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

#------------------------------------------------------------------------------
# Create user
#------------------------------------------------------------------------------
module "aim_user" {
    source                          = "../../modules/iam"

    name                            = "TEST-AIM-user"
    environment                     = "PROD"

    enable_iam_user                 = "true"
    iam_user_name                   = "aws-msk-user"
    iam_user_path                   = "/"
}

module "iam_user_ssh_key" {
    source                          = "../../modules/iam"

    enable_iam_user_ssh_key         = "true"
    iam_user_ssh_key_username       = "${module.aim_user.aws_iam_user_name}"
    
    iam_user_ssh_key_encoding       = "SSH"
    iam_user_ssh_key_public_key     = "${file("/Users/captain/.ssh/id_rsa.pub")}"
}

module  "iam_access_key" {
    source                          = "../../modules/iam"

    enable_iam_access_key           = "true"
    iam_access_key_user             = "${module.aim_user.aws_iam_user_name}"
    iam_access_key_pgp_key          = "keybase:captainua"
}

module "iam_user_policy" {
    source                          = "../../modules/iam"

    enable_iam_user_policy          = "true"
    iam_user_policy_name            = "policy-for-user"
    iam_user_policy_user            = "${module.aim_user.aws_iam_user_name}"
    iam_user_policy_policy          = "${file("additional_files/policies/iam_user_policy.json")}"
}

module "iam_user_login_profile" {
    source                                          = "../../modules/iam"

    enable_iam_user_login_profile                   = "true"
    iam_user_login_profile_user                     = "${module.aim_user.aws_iam_user_name}"
    iam_user_login_profile_pgp_key                  = "keybase:captainua"
    #iam_user_login_profile_pgp_key                  = "keybase:${module.aim_user.aws_iam_user_name}"
        
    iam_user_login_profile_password_length          = "20"
    iam_user_login_profile_password_reset_required  = "true"
    
}
