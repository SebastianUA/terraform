# Work with ATHENA via terraform

A terraform module for making ATHENA.


## Usage
----------------------
Import the module and retrieve with ```terraform get``` or ```terraform get --update```. Adding a module resource to your template, e.g. `main.tf`:

```
#
# MAINTAINER Vitaliy Natarov "vitaliy.natarov@yahoo.com"
#

terraform {
  required_version = "~> 1.0"
}

provider "aws" {
  region                  = "us-east-1"
  profile                 = "default"
  shared_credentials_file = pathexpand("~/.aws/credentials")
}

module "s3" {
  source      = "../../modules/s3"
  name        = "TEST"
  environment = "dev"

  # AWS S3 bucket
  enable_s3_bucket = true
  s3_bucket_name   = "natarov-test-bucket1"
  s3_bucket_acl    = "private"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })
}

data "template_file" "kms_key_policy" {
  template = file("./additional_files/kms_key_policy.json.tpl")
}

module "kms" {
  source = "../../modules/kms"

  name        = "tmp"
  environment = "dev"

  # KMS key
  enable_kms_key                  = true
  kms_key_name                    = "athena"
  kms_key_deletion_window_in_days = 30
  kms_key_policy                  = data.template_file.kms_key_policy.rendered

  # KMS alias
  enable_kms_alias = true
  kms_alias_name   = "alias/athena-key"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [data.template_file.kms_key_policy]
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

      result_configuration = {
        output_location = null

        encryption_configuration = {
          encryption_option = "SSE_KMS"
          kms_key_arn       = module.kms.kms_key_arn
        }
      }
    }
  ]

  # AWS athena named query
  enable_athena_named_query = true
  athena_named_query_name   = ""
  athena_named_query_query  = "SELECT * FROM ${module.athena.athena_database_id} limit 10;"

  tags = tomap({
    "Environment"   = "dev",
    "Createdby"     = "Vitaliy Natarov",
    "Orchestration" = "Terraform"
  })

  depends_on = [module.kms]

}

```

## Module Input Variables
----------------------
- `name` - Name to be used on all resources as prefix (`default = TEST`)
- `environment` - Environment for service (`default = STAGE`)
- `tags` - A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch. (`default = {}`)
- `enable_athena_database` - Enable athena DB usage (`default = False`)
- `athena_database_name` - Name of the database to create. (`default = ""`)
- `athena_database_bucket` - (Required) Name of s3 bucket to save the results of the query execution. (`default = ""`)
- `athena_database_force_destroy` - (Optional, Default: false) A boolean that indicates all tables should be deleted from the database so that the database can be destroyed without error. The tables are not recoverable. (`default = False`)
- `athena_database_encryption_configuration` - (Optional) The encryption key block AWS Athena uses to decrypt the data in S3, such as an AWS Key Management Service (AWS KMS) key. An encryption_configuration block is documented below. (`default = []`)
- `enable_athena_named_query` - Enable athena named query usage (`default = False`)
- `athena_named_query_name` - The plain language name for the query. Maximum length of 128. (`default = ""`)
- `athena_named_query_workgroup` - (Optional) The workgroup to which the query belongs. Defaults to primary (`default = primary`)
- `athena_named_query_database` - The database to which the query belongs. (`default = ""`)
- `athena_named_query_description` - (Optional) A brief explanation of the query. Maximum length of 1024. (`default = ""`)
- `athena_named_query_query` - (Required) The text of the query itself. In other words, all query statements. Maximum length of 262144. (`default = ""`)
- `enable_athena_workgroup` - Enable athena workgroup usage (`default = False`)
- `athena_workgroup_name` - Name of the workgroup. (`default = ""`)
- `athena_workgroup_description` - (Optional) Description of the workgroup. (`default = null`)
- `athena_workgroup_state` - (Optional) State of the workgroup. Valid values are DISABLED or ENABLED. Defaults to ENABLED. (`default = null`)
- `athena_workgroup_force_destroy` - (Optional) The option to delete the workgroup and its contents even if the workgroup contains any named queries. (`default = null`)
- `athena_workgroup_configuration` - (Optional) Configuration block with various settings for the workgroup. (`default = []`)

## Module Output Variables
----------------------
- `athena_database_id` - The database name
- `athena_named_query_id` - The unique ID of the query.
- `athena_workgroup_id` - The workgroup name
- `athena_workgroup_arn` - Amazon Resource Name (ARN) of the workgroup


## Authors

Created and maintained by [Vitaliy Natarov](https://github.com/SebastianUA). An email: [vitaliy.natarov@yahoo.com](vitaliy.natarov@yahoo.com).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/SebastianUA/terraform/blob/master/LICENSE) for full details.
