#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
    required_version = "~> 0.12.12"
}

provider "aws" {
    region                  = "us-east-1"
    profile                 = "default"
    shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "s3" {
    source                                  = "../../modules/s3"
    name                                    = "TEST"
    environment                             = "NonPROD"
    region                                  = "us-east-1"

    enable_s3_bucket                        = true
    s3_bucket_name                          = "my-test-bucket"
    s3_bucket_acl                           = "private"
    s3_bucket_cors_rule                     = []

    s3_bucket_versioning                    = []
    enable_lifecycle_rule                   = true
    
    # Add policy to the bucket
    enable_s3_bucket_policy                 = false

}

data "template_file" "kms_key_policy" {
    template = file("policies/kms_key_policy.json.tpl")
}

module "kms" {
    source              = "../../modules/kms"

    enable_kms_key      = true
    name                = "TESTKMS"
    environment         = "stage"
    key_usage           = "ENCRYPT_DECRYPT"

    policy              = data.template_file.kms_key_policy.rendered

}

module "athena" {
    source                                      = "../../modules/athena"

    enable_athena_database                      = true
    athena_database_name                        = ""
    athena_database_bucket                      = "${module.s3.s3_bucket_id}"
    #athena_database_encryption_configuration    = ["encryption_option", "test", "kms_key", "kms_key"]

    enable_athena_workgroup                     = true
    athena_workgroup_name                       = ""
    athena_workgroup_encryption_option          = "SSE_KMS"
    athena_workgroup_kms_key_arn                = "${module.kms.kms_key_arn}"
    
    enable_athena_named_query                   = true
    athena_named_query_name                     = ""
    athena_named_query_query                    = "SELECT * FROM ${module.athena.athena_database_id} limit 10;"
                        
}
