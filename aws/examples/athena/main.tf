#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 0.13"
}

provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "s3" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "NonPROD"

  enable_s3_bucket    = true
  s3_bucket_name      = "my-test-bucket"
  s3_bucket_acl       = "private"
  s3_bucket_cors_rule = []

  s3_bucket_versioning  = []
  enable_lifecycle_rule = true

  # Add policy to the bucket
  enable_s3_bucket_policy = false

}

data "template_file" "kms_key_policy" {
  template = file("policies/kms_key_policy.json.tpl")
}

module "kms" {
  source = "../../modules/kms"

  enable_kms_key = true
  name           = "TESTKMS"
  environment    = "stage"
  key_usage      = "ENCRYPT_DECRYPT"

  policy = data.template_file.kms_key_policy.rendered

}

module "athena" {
  source = "../../modules/athena"

  # AWS athena database
  enable_athena_database = true
  athena_database_name   = "_myunderscoretable"
  athena_database_bucket = module.s3.s3_bucket_id
  athena_database_encryption_configuration = [
    {
      encryption_option = "SSE_KMS"
      kms_key           = module.kms.kms_key_arn
    }
  ]
  force_destroy = false

  # 
  enable_athena_workgroup        = true
  athena_workgroup_name          = "workgroup-1"
  athena_workgroup_description   = "Test athena workgroup"
  athena_workgroup_state         = "ENABLED"
  athena_workgroup_force_destroy = null

  athena_workgroup_configuration = [
    {
      bytes_scanned_cutoff_per_query     = 10485760
      enforce_workgroup_configuration    = true
      publish_cloudwatch_metrics_enabled = true

      output_location = null

      encryption_option = "SSE_KMS"
      kms_key_arn       = module.kms.kms_key_arn

    }
  ]

  # AWS athena named query
  enable_athena_named_query = true
  athena_named_query_name   = ""
  athena_named_query_query  = "SELECT * FROM ${module.athena.athena_database_id} limit 10;"

  tags = map("Env", "stage", "Orchestration", "Terraform")

}
